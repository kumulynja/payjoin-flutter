import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bdk_flutter/bdk_flutter.dart' as bdk;
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:payjoin_flutter/common.dart' as common;
import 'package:payjoin_flutter/common.dart';
import 'package:payjoin_flutter/receive/v1.dart' as v1;
import 'package:payjoin_flutter/receive/v2.dart';
import 'package:payjoin_flutter/send.dart' as send;
import 'package:payjoin_flutter/uri.dart' as payjoin_uri;
import 'package:payjoin_flutter_example/bdk_client.dart';
import 'package:payjoin_flutter_example/btc_client.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('v1_to_v1', () {
    setUp(() async {});
    testWidgets('full_cycle', (WidgetTester tester) async {
      final btcClient = BtcClient("sender");
      await btcClient.loadWallet();
      final sender = BdkClient(
          "wpkh(tprv8ZgxMBicQKsPfNH1PykMg16TAvrZgoxDnxr3eorcbhvZxyZzStwFkvqCJegr8Gbwj3GQum8QpXQPh7DGkoobpTB7YbcnUeUSKRDyX2cNN9h/84'/1'/0'/0/*)#ey7hlgpn",
          bdk.Network.regtest);
      final receiver = BdkClient(
          "wpkh(tprv8ZgxMBicQKsPczV7D2zfMr7oUzHDhNPEuBUgrwRoWM3ijLRvhG87xYiqh9JFLPqojuhmqwMdo1oJzbe5GUpxCbDHnqyGhQa5Jg1Wt6rc9di/84'/1'/0'/0/*)#kdnuw5lq",
          bdk.Network.regtest);
      await sender.restoreWallet();
      await receiver.restoreWallet();
      // Receiver creates the payjoin URI
      final pjReceiverAddress = receiver.getNewAddress().address;
      final pjSenderAddress = sender.getNewAddress().address;
      await btcClient.sendToAddress(pjSenderAddress.toString(), 1);
      await btcClient.sendToAddress(pjReceiverAddress.toString(), 1);
      await btcClient.generate(11, pjSenderAddress.toString());
      await receiver.syncWallet();
      await sender.syncWallet();
      // Sender create a funded PSBT (not broadcast) to address with amount given in the pjUri
      debugPrint("Sender Balance: ${sender.getBalance().toString()}");
      final uri = await payjoin_uri.Uri.fromStr(
          "${pjReceiverAddress.toQrUri()}?amount=${0.0083285}&pj=https://example.com");
      final address = uri.address();
      int amount = (((uri.amount()) ?? 0) * 100000000).toInt();

      final senderPsbt = (await sender.createPsbt(address, amount, 2000));

      debugPrint(
        "\nOriginal sender psbt: $senderPsbt",
      );

      // Receiver part
      final (req, ctx) = await (await (await send.RequestBuilder.fromPsbtAndUri(
                  psbtBase64: senderPsbt, pjUri: uri.checkPjSupported()))
              .buildWithAdditionalFee(
                  maxFeeContribution: BigInt.from(10000),
                  minFeeRate: BigInt.zero,
                  clampFeeContribution: false))
          .extractV1();
      final headers = common.Headers(map: {
        'content-type': 'text/plain',
        'content-length': req.body.length.toString(),
      });
      final uncheckedProposal = await v1.UncheckedProposal.fromRequest(
          body: req.body.toList(), query: (req.url.query())!, headers: headers);
      // in a payment processor where the sender could go offline, this is where you schedule to broadcast the original_tx
      var _ = await uncheckedProposal.extractTxToScheduleBroadcast();
      final inputsOwned = await uncheckedProposal.checkBroadcastSuitability(
          canBroadcast: (e) async {
        return true;
      });
      // Receive Check 2: receiver can't sign for proposal inputs
      final mixedInputScripts =
          await inputsOwned.checkInputsNotOwned(isOwned: (e) async {
        return receiver.getAddressInfo(bdk.ScriptBuf(bytes: e));
      });

      // Receive Check 3: receiver can't sign for proposal inputs
      final seenInputs = await mixedInputScripts.checkNoMixedInputScripts();
      // Receive Check 4: have we seen this input before? More of a check for non-interactive i.e. payment processor receivers.
      final provisionalProposal =
          await (await seenInputs.checkNoInputsSeenBefore(isKnown: (e) async {
        return false;
      }))
              .identifyReceiverOutputs(isReceiverOutput: (e) async {
        return receiver.getAddressInfo(bdk.ScriptBuf(bytes: e));
      });
      final unspent = receiver.listUnspent();
      // Select receiver payjoin inputs.
      Map<BigInt, common.OutPoint> candidateInputs = {
        for (var input in unspent)
          input.txout.value: common.OutPoint(
              txid: input.outpoint.txid.toString(), vout: input.outpoint.vout)
      };
      final selectedOutpoint = await provisionalProposal.tryPreservingPrivacy(
          candidateInputs: candidateInputs);
      var selectedUtxo = unspent.firstWhere(
          (i) =>
              i.outpoint.txid.toString() == selectedOutpoint.txid &&
              i.outpoint.vout == selectedOutpoint.vout,
          orElse: () => throw Exception('UTXO not found'));
      var txoToContribute = common.TxOut(
        value: selectedUtxo.txout.value,
        scriptPubkey: selectedUtxo.txout.scriptPubkey.bytes,
      );

      var outpointToContribute = common.OutPoint(
        txid: selectedUtxo.outpoint.txid.toString(),
        vout: selectedUtxo.outpoint.vout,
      );
      await provisionalProposal.contributeWitnessInput(
          txo: txoToContribute, outpoint: outpointToContribute);

      final payJoinProposal =
          await provisionalProposal.finalizeProposal(processPsbt: (e) async {
        debugPrint("\n Original receiver unsigned psbt: $e");
        return await receiver.processPsbt(e);
      });
      final receiverPsbt = await payJoinProposal.psbt();
      debugPrint("\n Original receiver psbt: $receiverPsbt");
      final receiverProcessedPsbt =
          await ctx.processResponse(response: utf8.encode(receiverPsbt));
      final senderProcessedPsbt =
          await sender.processPsbt(receiverProcessedPsbt);

      final txid = await sender.broadcastPsbt(
        await bdk.PartiallySignedTransaction.fromString(senderProcessedPsbt),
      );
      debugPrint("Broadcast success: $txid");
    });
  });

  group('v2', () {
    const v2ContentType = "message/ohttp-req";
    const network = bdk.Network.signet;
    const ohttpRelay = "https://pj.bobspacebkk.com";
    const payjoinDirectory = "https://payjo.in";

    Future<(BdkClient sender, BdkClient receiver)> initSenderReceiver() async {
      final receiverSecret = await bdk.DescriptorSecretKey.create(
        network: network,
        mnemonic: await bdk.Mnemonic.fromString(
          "pyramid rebuild april purchase elbow negative useless strong smooth alter current stomach",
        ),
      );
      final senderSecret = await bdk.DescriptorSecretKey.create(
        network: network,
        mnemonic: await bdk.Mnemonic.fromString(
          "order battle scare loud useless island tone vague skin present ensure hip",
        ),
      );

      final receiverDescriptor = await bdk.Descriptor.newBip86(
        secretKey: receiverSecret,
        network: network,
        keychain: bdk.KeychainKind.externalChain,
      );
      final senderDescriptor = await bdk.Descriptor.newBip86(
        secretKey: senderSecret,
        network: network,
        keychain: bdk.KeychainKind.externalChain,
      );

      final receiver = BdkClient(
        receiverDescriptor.toStringPrivate(),
        network,
      );
      final sender = BdkClient(
        senderDescriptor.toStringPrivate(),
        network,
      );
      await Future.wait([
        receiver.restoreWallet(),
        sender.restoreWallet(),
      ]);
      await Future.wait([
        receiver.syncWallet(),
        sender.syncWallet(),
      ]);
      print('Receiver balance: ${receiver.getBalance()}');
      print('Sender balance: ${sender.getBalance()}');
      return (sender, receiver);
    }

    Future<ActiveSession> initializeSession({
      required String address,
      required BigInt expireAfter,
      required common.Network network,
      required payjoin_uri.Url ohttpRelay,
      required payjoin_uri.Url directory,
      required payjoin_uri.OhttpKeys ohttpKeys,
    }) async {
      final sessionInitializer = await SessionInitializer.create(
        directory: directory,
        ohttpKeys: ohttpKeys,
        address: address,
        expireAfter: expireAfter,
        network: network,
        ohttpRelay: ohttpRelay,
      );
      final (req, ctx) = await sessionInitializer.extractReq();
      final response = await http.post(
        Uri.parse(req.url.asString()),
        body: req.body,
        headers: {
          'Content-Type': v2ContentType,
        },
      );
      assert(response.statusCode == 200);
      final activeSession = await sessionInitializer.processRes(
        body: response.bodyBytes,
        ctx: ctx,
      );

      return activeSession;
    }

    Future<String> buildOriginalPsbt(
      BdkClient sender,
      payjoin_uri.Uri pjUri,
    ) async {
      double uriAmount = pjUri.amount() ?? 0;
      int amountSat = (uriAmount * 100000000.0).round();
      final psbt = await sender.createPsbt(pjUri.address(), amountSat, 500);

      return psbt;
    }

    Future<PayjoinProposal> handleDirectoryProposal(
      BdkClient receiver,
      UncheckedProposal proposal,
    ) async {
      final originalTxBytes = await proposal.extractTxToScheduleBroadcast();
      final _ =
          await bdk.Transaction.fromBytes(transactionBytes: originalTxBytes);

      // Receive Check 1: Can Broadcast
      final ownedInputs =
          await proposal.checkBroadcastSuitability(canBroadcast: (e) async {
        return true;
      });

      // Receive Check 2: receiver can't sign for proposal inputs
      final mixedInputScripts = await ownedInputs.checkInputsNotOwned(
          isOwned: (i) => receiver.isOwned(i));

      // Receive Check 3: receiver can't sign for proposal inputs
      final seenInputs = await mixedInputScripts.checkNoMixedInputScripts();

      // Receive Check 4: have we seen this input before? More of a check for non-interactive i.e. payment processor receivers.
      final payjoin =
          await (await seenInputs.checkNoInputsSeenBefore(isKnown: (e) async {
        return false;
      }))
              .identifyReceiverOutputs(
        isReceiverOutput: (i) => receiver.isOwned(i),
      );

      // Select receiver payjoin inputs. TODO Lock them.
      final availableInputs = receiver.listUnspent();
      Map<BigInt, OutPoint> candidateInputs = {
        for (var input in availableInputs)
          input.txout.value: OutPoint(
            txid: input.outpoint.txid.toString(),
            vout: input.outpoint.vout,
          )
      };
      final selectedOutpoint = await payjoin.tryPreservingPrivacy(
        candidateInputs: candidateInputs,
      );
      var selectedUtxo = availableInputs.firstWhere(
          (i) =>
              i.outpoint.txid == selectedOutpoint.txid &&
              i.outpoint.vout == selectedOutpoint.vout,
          orElse: () => throw Exception('UTXO not found'));
      var txoToContribute = TxOut(
        value: selectedUtxo.txout.value,
        scriptPubkey: selectedUtxo.txout.scriptPubkey.bytes,
      );

      var outpointToContribute = OutPoint(
        txid: selectedUtxo.outpoint.txid.toString(),
        vout: selectedUtxo.outpoint.vout,
      );
      await payjoin.contributeWitnessInput(
        txo: txoToContribute,
        outpoint: outpointToContribute,
      );

      /* PjUri is generated with pjos=0, so no output substitution is permitted
      payjoin.trySubstituteReceiverOutput(
          generateScript: () async => receiverWallet
              .getAddress(addressIndex: const bdk.AddressIndex.increase())
              .address
              .scriptPubkey()
              .bytes);*/
      final payjoinProposal = await payjoin.finalizeProposal(
          processPsbt: (i) => receiver.processPsbt(i));
      return payjoinProposal;
    }

    testWidgets('v2_to_v2', (WidgetTester tester) async {
      final (sender, receiver) = await initSenderReceiver();

      final ohttpRelayUrl = await payjoin_uri.Url.fromStr(ohttpRelay);
      final payjoinDirectoryUrl =
          await payjoin_uri.Url.fromStr(payjoinDirectory);
      final ohttpKeys = await payjoin_uri.fetchOhttpKeys(
        ohttpRelay: ohttpRelayUrl,
        payjoinDirectory: payjoinDirectoryUrl,
      );

      // **********************
      // Inside the Receiver:
      final address = receiver.getNewAddress().address;
      final session = await initializeSession(
        directory: payjoinDirectoryUrl,
        ohttpKeys: ohttpKeys,
        address: address.asString(),
        expireAfter: BigInt.from(const Duration(minutes: 15).inSeconds),
        network: network.toPayjoinNetwork,
        ohttpRelay: ohttpRelayUrl,
      );

      final pjUriString = session
          .pjUriBuilder()
          .amount(amount: BigInt.from(10000))
          .build()
          .asString();
      debugPrint('pjUri: $pjUriString');
      // Poll receive request
      final (initReceiveReq, initReceiveCtx) = await session.extractReq();
      final initResponse = await http.post(
        Uri.parse(initReceiveReq.url.asString()),
        body: initReceiveReq.body,
        headers: {
          'Content-Type': v2ContentType,
        },
      );
      assert(initResponse.statusCode == 200);
      final initUncheckedProposal = await session.processRes(
        body: initResponse.bodyBytes,
        ctx: initReceiveCtx,
      );
      // No proposal yet since sender has not responded
      assert(initUncheckedProposal == null);

      // **********************
      // Inside the Sender:
      // Create a funded PSBT (not broadcasted) to address with amount given in the pjUri
      final pjUri = (await payjoin_uri.Uri.fromStr(pjUriString));
      final psbt = await buildOriginalPsbt(sender, pjUri);
      final requestBuilder = await send.RequestBuilder.fromPsbtAndUri(
        psbtBase64: psbt,
        pjUri: pjUri.checkPjSupported(),
      );
      final reqCtx = await requestBuilder.buildRecommended(
        minFeeRate: BigInt.zero,
      );
      final (sendReq, sendCtx) = await reqCtx.extractV2(
        ohttpProxyUrl: payjoinDirectoryUrl,
      );
      final sendResponse = await http.post(
        Uri.parse(sendReq.url.asString()),
        body: sendReq.body,
        headers: {
          'Content-Type': v2ContentType,
        },
      );
      debugPrint('send_response: $sendResponse');
      assert(sendResponse.statusCode == 200);
      final sendResponseBody = await sendCtx.processResponse(
        response: sendResponse.bodyBytes,
      );
      // No response body yet since we are async and pushed fallback_psbt to the buffer
      assert(sendResponseBody == null || sendResponseBody.isEmpty);

      // **********************
      // Inside the Receiver:

      // GET fallback psbt
      final (fallbackReceiveReq, fallbackReceiveCtx) =
          await session.extractReq();
      final fallbackResponse = await http.post(
        Uri.parse(fallbackReceiveReq.url.asString()),
        body: fallbackReceiveReq.body,
        headers: {'Content-Type': v2ContentType},
      );
      // POST payjoin
      final fallbackProposal = await session.processRes(
        body: fallbackResponse.bodyBytes,
        ctx: fallbackReceiveCtx,
      );
      assert(fallbackProposal != null);
      final payjoinProposal = await handleDirectoryProposal(
        receiver,
        fallbackProposal!,
      );
      final (proposalReq, proposalCtx) = await payjoinProposal.extractV2Req();
      final proposalResponse = await http.post(
        Uri.parse(proposalReq.url.asString()),
        body: proposalReq.body,
        headers: {'Content-Type': v2ContentType},
      );
      await payjoinProposal.processRes(
        res: proposalResponse.bodyBytes,
        ohttpContext: proposalCtx,
      );

      // **********************
      // Inside the Sender:
      // Sender checks, signs, finalizes, extracts, and broadcasts

      // Replay post fallback to get the response
      final (replaySendReq, replaySendCtx) = await reqCtx.extractV2(
        ohttpProxyUrl: payjoinDirectoryUrl,
      );
      final replaySendResponse = await http.post(
        Uri.parse(replaySendReq.url.asString()),
        body: replaySendReq.body,
        headers: {'Content-Type': v2ContentType},
      );

      debugPrint('replay_send_response: $replaySendResponse');
      final checkedPayjoinProposal = await replaySendCtx.processResponse(
        response: replaySendResponse.bodyBytes,
      );
      assert(checkedPayjoinProposal != null);
      final payjoinTxId = await sender.broadcastPsbt(
        await bdk.PartiallySignedTransaction.fromString(
          checkedPayjoinProposal!,
        ),
      );
      debugPrint('Payjoin txid: $payjoinTxId');
    }, timeout: const Timeout(Duration(minutes: 15)));
  });
}

extension NetworkX on bdk.Network {
  common.Network get toPayjoinNetwork {
    switch (this) {
      case bdk.Network.bitcoin:
        return common.Network.bitcoin;
      case bdk.Network.testnet:
        return common.Network.testnet;
      case bdk.Network.regtest:
        return common.Network.regtest;
      case bdk.Network.signet:
        return common.Network.signet;
    }
  }
}
