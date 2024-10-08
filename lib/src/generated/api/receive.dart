// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import '../lib.dart';
import '../utils/error.dart';
import '../utils/types.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'uri.dart';

// These functions are ignored because they are not marked as `pub`: `_finalize_proposal`
// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `clone`, `clone`, `clone`, `fmt`, `fmt`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`

class FfiActiveSession {
  final ActiveSession field0;

  const FfiActiveSession({
    required this.field0,
  });

  Future<(Request, ClientResponse)> extractReq() =>
      core.instance.api.crateApiReceiveFfiActiveSessionExtractReq(
        that: this,
      );

  FfiPjUriBuilder pjUriBuilder() =>
      core.instance.api.crateApiReceiveFfiActiveSessionPjUriBuilder(
        that: this,
      );

  Future<FfiUrl> pjUrl() =>
      core.instance.api.crateApiReceiveFfiActiveSessionPjUrl(
        that: this,
      );

  Future<FfiV2UncheckedProposal?> processRes(
          {required List<int> body, required ClientResponse ctx}) =>
      core.instance.api.crateApiReceiveFfiActiveSessionProcessRes(
          that: this, body: body, ctx: ctx);

  ///The per-session public key to use as an identifier
  String publicKey() =>
      core.instance.api.crateApiReceiveFfiActiveSessionPublicKey(
        that: this,
      );

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiActiveSession &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiMaybeInputsOwned {
  final MaybeInputsOwned field0;

  const FfiMaybeInputsOwned({
    required this.field0,
  });

  Future<FfiMaybeMixedInputScripts> checkInputsNotOwned(
          {required FutureOr<bool> Function(Uint8List) isOwned}) =>
      core.instance.api.crateApiReceiveFfiMaybeInputsOwnedCheckInputsNotOwned(
          that: this, isOwned: isOwned);

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiMaybeInputsOwned &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiMaybeInputsSeen {
  final MaybeInputsSeen field0;

  const FfiMaybeInputsSeen({
    required this.field0,
  });

  Future<FfiOutputsUnknown> checkNoInputsSeenBefore(
          {required FutureOr<bool> Function(OutPoint) isKnown}) =>
      core.instance.api
          .crateApiReceiveFfiMaybeInputsSeenCheckNoInputsSeenBefore(
              that: this, isKnown: isKnown);

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiMaybeInputsSeen &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiMaybeMixedInputScripts {
  final MaybeMixedInputScripts field0;

  const FfiMaybeMixedInputScripts({
    required this.field0,
  });

  Future<FfiMaybeInputsSeen> checkNoMixedInputScripts() => core.instance.api
          .crateApiReceiveFfiMaybeMixedInputScriptsCheckNoMixedInputScripts(
        that: this,
      );

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiMaybeMixedInputScripts &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiOutputsUnknown {
  final OutputsUnknown field0;

  const FfiOutputsUnknown({
    required this.field0,
  });

  Future<FfiProvisionalProposal> identifyReceiverOutputs(
          {required FutureOr<bool> Function(Uint8List) isReceiverOutput}) =>
      core.instance.api.crateApiReceiveFfiOutputsUnknownIdentifyReceiverOutputs(
          that: this, isReceiverOutput: isReceiverOutput);

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiOutputsUnknown &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiPayjoinProposal {
  final PayjoinProposal field0;

  const FfiPayjoinProposal({
    required this.field0,
  });

  Future<bool> isOutputSubstitutionDisabled() => core.instance.api
          .crateApiReceiveFfiPayjoinProposalIsOutputSubstitutionDisabled(
        that: this,
      );

  Future<Uint64List> ownedVouts() =>
      core.instance.api.crateApiReceiveFfiPayjoinProposalOwnedVouts(
        that: this,
      );

  Future<String> psbt() =>
      core.instance.api.crateApiReceiveFfiPayjoinProposalPsbt(
        that: this,
      );

  Future<List<OutPoint>> utxosToBeLocked() =>
      core.instance.api.crateApiReceiveFfiPayjoinProposalUtxosToBeLocked(
        that: this,
      );

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiPayjoinProposal &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiProvisionalProposal {
  final ProvisionalProposal field0;

  const FfiProvisionalProposal({
    required this.field0,
  });

  Future<void> contributeWitnessInput(
          {required TxOut txo, required OutPoint outpoint}) =>
      core.instance.api
          .crateApiReceiveFfiProvisionalProposalContributeWitnessInput(
              that: this, txo: txo, outpoint: outpoint);

  Future<FfiPayjoinProposal> finalizeProposal(
          {required FutureOr<String> Function(String) processPsbt,
          BigInt? minFeeRateSatPerVb}) =>
      core.instance.api.crateApiReceiveFfiProvisionalProposalFinalizeProposal(
          that: this,
          processPsbt: processPsbt,
          minFeeRateSatPerVb: minFeeRateSatPerVb);

  Future<OutPoint> tryPreservingPrivacy(
          {required Map<BigInt, OutPoint> candidateInputs}) =>
      core.instance.api
          .crateApiReceiveFfiProvisionalProposalTryPreservingPrivacy(
              that: this, candidateInputs: candidateInputs);

  Future<void> trySubstituteReceiverOutput(
          {required FutureOr<Uint8List> Function() generateScript}) =>
      core.instance.api
          .crateApiReceiveFfiProvisionalProposalTrySubstituteReceiverOutput(
              that: this, generateScript: generateScript);

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiProvisionalProposal &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiSessionInitializer {
  final SessionInitializer field0;

  const FfiSessionInitializer({
    required this.field0,
  });

  Future<(Request, ClientResponse)> extractReq() =>
      core.instance.api.crateApiReceiveFfiSessionInitializerExtractReq(
        that: this,
      );

  // HINT: Make it `#[frb(sync)]` to let it become the default constructor of Dart class.
  static Future<FfiSessionInitializer> newInstance(
          {required String address,
          BigInt? expireAfter,
          required Network network,
          required FfiUrl directory,
          required FfiOhttpKeys ohttpKeys,
          required FfiUrl ohttpRelay}) =>
      core.instance.api.crateApiReceiveFfiSessionInitializerNew(
          address: address,
          expireAfter: expireAfter,
          network: network,
          directory: directory,
          ohttpKeys: ohttpKeys,
          ohttpRelay: ohttpRelay);

  Future<FfiActiveSession> processRes(
          {required List<int> body, required ClientResponse ctx}) =>
      core.instance.api.crateApiReceiveFfiSessionInitializerProcessRes(
          that: this, body: body, ctx: ctx);

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiSessionInitializer &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiUncheckedProposal {
  final UncheckedProposal field0;

  const FfiUncheckedProposal({
    required this.field0,
  });

  /// Call this method if the only way to initiate a Payjoin with this receiver requires manual intervention, as in most consumer wallets.
  ///
  /// So-called “non-interactive” receivers, like payment processors, that allow arbitrary requests are otherwise vulnerable to probing attacks. Those receivers call get_transaction_to_check_broadcast() and attest_tested_and_scheduled_broadcast() after making those checks downstream.
  Future<FfiMaybeInputsOwned> assumeInteractiveReceiver() => core.instance.api
          .crateApiReceiveFfiUncheckedProposalAssumeInteractiveReceiver(
        that: this,
      );

  /// Call after checking that the Original PSBT can be broadcast.
  ///
  /// Receiver MUST check that the Original PSBT from the sender can be broadcast, i.e. testmempoolaccept bitcoind rpc returns { “allowed”: true,.. } for get_transaction_to_check_broadcast() before calling this method.
  ///
  /// Do this check if you generate bitcoin uri to receive Payjoin on sender request without manual human approval, like a payment processor. Such so called “non-interactive” receivers are otherwise vulnerable to probing attacks. If a sender can make requests at will, they can learn which bitcoin the receiver owns at no cost. Broadcasting the Original PSBT after some time in the failure case makes incurs sender cost and prevents probing.
  ///
  /// Call this after checking downstream.
  Future<FfiMaybeInputsOwned> checkBroadcastSuitability(
          {BigInt? minFeeRate,
          required FutureOr<bool> Function(Uint8List) canBroadcast}) =>
      core.instance.api
          .crateApiReceiveFfiUncheckedProposalCheckBroadcastSuitability(
              that: this, minFeeRate: minFeeRate, canBroadcast: canBroadcast);

  /// The Sender’s Original PSBT
  Future<Uint8List> extractTxToScheduleBroadcast() => core.instance.api
          .crateApiReceiveFfiUncheckedProposalExtractTxToScheduleBroadcast(
        that: this,
      );

  static Future<FfiUncheckedProposal> fromRequest(
          {required List<int> body,
          required String query,
          required Headers headers}) =>
      core.instance.api.crateApiReceiveFfiUncheckedProposalFromRequest(
          body: body, query: query, headers: headers);

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiUncheckedProposal &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiV2MaybeInputsOwned {
  final V2MaybeInputsOwned field0;

  const FfiV2MaybeInputsOwned({
    required this.field0,
  });

  ///Check that the Original PSBT has no receiver-owned inputs. Return original-psbt-rejected error or otherwise refuse to sign undesirable inputs.
  /// An attacker could try to spend receiver's own inputs. This check prevents that.
  Future<FfiV2MaybeMixedInputScripts> checkInputsNotOwned(
          {required FutureOr<bool> Function(Uint8List) isOwned}) =>
      core.instance.api.crateApiReceiveFfiV2MaybeInputsOwnedCheckInputsNotOwned(
          that: this, isOwned: isOwned);

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiV2MaybeInputsOwned &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiV2MaybeInputsSeen {
  final V2MaybeInputsSeen field0;

  const FfiV2MaybeInputsSeen({
    required this.field0,
  });

  /// Make sure that the original transaction inputs have never been seen before.
  /// This prevents probing attacks. This prevents reentrant Payjoin, where a sender
  /// proposes a Payjoin PSBT as a new Original PSBT for a new Payjoin.
  Future<FfiV2OutputsUnknown> checkNoInputsSeenBefore(
          {required FutureOr<bool> Function(OutPoint) isKnown}) =>
      core.instance.api
          .crateApiReceiveFfiV2MaybeInputsSeenCheckNoInputsSeenBefore(
              that: this, isKnown: isKnown);

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiV2MaybeInputsSeen &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiV2MaybeMixedInputScripts {
  final V2MaybeMixedInputScripts field0;

  const FfiV2MaybeMixedInputScripts({
    required this.field0,
  });

  /// Verify the original transaction did not have mixed input types
  /// Call this after checking downstream.
  ///
  /// Note: mixed spends do not necessarily indicate distinct wallet fingerprints.
  /// This check is intended to prevent some types of wallet fingerprinting.
  Future<FfiV2MaybeInputsSeen> checkNoMixedInputScripts() => core.instance.api
          .crateApiReceiveFfiV2MaybeMixedInputScriptsCheckNoMixedInputScripts(
        that: this,
      );

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiV2MaybeMixedInputScripts &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiV2OutputsUnknown {
  final V2OutputsUnknown field0;

  const FfiV2OutputsUnknown({
    required this.field0,
  });

  /// Find which outputs belong to the receiver
  Future<FfiV2ProvisionalProposal> identifyReceiverOutputs(
          {required FutureOr<bool> Function(Uint8List) isReceiverOutput}) =>
      core.instance.api
          .crateApiReceiveFfiV2OutputsUnknownIdentifyReceiverOutputs(
              that: this, isReceiverOutput: isReceiverOutput);

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiV2OutputsUnknown &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiV2PayjoinProposal {
  final ArcV2PayjoinProposal field0;

  const FfiV2PayjoinProposal({
    required this.field0,
  });

  Future<String> extractV1Req() =>
      core.instance.api.crateApiReceiveFfiV2PayjoinProposalExtractV1Req(
        that: this,
      );

  Future<(Request, ClientResponse)> extractV2Req() =>
      core.instance.api.crateApiReceiveFfiV2PayjoinProposalExtractV2Req(
        that: this,
      );

  Future<bool> isOutputSubstitutionDisabled() => core.instance.api
          .crateApiReceiveFfiV2PayjoinProposalIsOutputSubstitutionDisabled(
        that: this,
      );

  Future<Uint64List> ownedVouts() =>
      core.instance.api.crateApiReceiveFfiV2PayjoinProposalOwnedVouts(
        that: this,
      );

  Future<void> processRes(
          {required List<int> res, required ClientResponse ohttpContext}) =>
      core.instance.api.crateApiReceiveFfiV2PayjoinProposalProcessRes(
          that: this, res: res, ohttpContext: ohttpContext);

  Future<String> psbt() =>
      core.instance.api.crateApiReceiveFfiV2PayjoinProposalPsbt(
        that: this,
      );

  Future<List<OutPoint>> utxosToBeLocked() =>
      core.instance.api.crateApiReceiveFfiV2PayjoinProposalUtxosToBeLocked(
        that: this,
      );

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiV2PayjoinProposal &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiV2ProvisionalProposal {
  final V2ProvisionalProposal field0;

  const FfiV2ProvisionalProposal({
    required this.field0,
  });

  Future<void> contributeWitnessInput(
          {required TxOut txo, required OutPoint outpoint}) =>
      core.instance.api
          .crateApiReceiveFfiV2ProvisionalProposalContributeWitnessInput(
              that: this, txo: txo, outpoint: outpoint);

  Future<FfiV2PayjoinProposal> finalizeProposal(
          {required FutureOr<String> Function(String) processPsbt,
          BigInt? minFeeRateSatPerVb}) =>
      core.instance.api.crateApiReceiveFfiV2ProvisionalProposalFinalizeProposal(
          that: this,
          processPsbt: processPsbt,
          minFeeRateSatPerVb: minFeeRateSatPerVb);

  Future<bool> isOutputSubstitutionDisabled() => core.instance.api
          .crateApiReceiveFfiV2ProvisionalProposalIsOutputSubstitutionDisabled(
        that: this,
      );

  /// Select receiver input such that the common.dart avoids surveillance. Return the input chosen that has been applied to the Proposal.
  ///
  /// Proper coin selection allows common.dart to resemble ordinary transactions. To ensure the resemblance, a number of heuristics must be avoided.
  ///
  /// UIH “Unnecessary input heuristic” is one class of them to avoid. We define UIH1 and UIH2 according to the BlockSci practice BlockSci UIH1 and UIH2:
  Future<OutPoint> tryPreservingPrivacy(
          {required Map<BigInt, OutPoint> candidateInputs}) =>
      core.instance.api
          .crateApiReceiveFfiV2ProvisionalProposalTryPreservingPrivacy(
              that: this, candidateInputs: candidateInputs);

  Future<void> trySubstituteReceiverOutput(
          {required FutureOr<Uint8List> Function() generateScript}) =>
      core.instance.api
          .crateApiReceiveFfiV2ProvisionalProposalTrySubstituteReceiverOutput(
              that: this, generateScript: generateScript);

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiV2ProvisionalProposal &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiV2UncheckedProposal {
  final V2UncheckedProposal field0;

  const FfiV2UncheckedProposal({
    required this.field0,
  });

  /// Call this method if the only way to initiate a Payjoin with this receiver
  /// requires manual intervention, as in most consumer wallets.
  ///
  /// So-called "non-interactive" receivers, like payment processors, that allow arbitrary requests are otherwise vulnerable to probing attacks.
  /// Those receivers call `extract_tx_to_check_broadcast()` and `attest_tested_and_scheduled_broadcast()` after making those checks downstream.
  Future<FfiV2MaybeInputsOwned> assumeInteractiveReceiver() => core.instance.api
          .crateApiReceiveFfiV2UncheckedProposalAssumeInteractiveReceiver(
        that: this,
      );

  /// Call after checking that the Original PSBT can be broadcast.
  ///
  /// Receiver MUST check that the Original PSBT from the sender can be broadcast, i.e. testmempoolaccept bitcoind rpc returns { “allowed”: true,.. } for get_transaction_to_check_broadcast() before calling this method.
  ///
  /// Do this check if you generate bitcoin uri to receive Payjoin on sender request without manual human approval, like a payment processor. Such so called “non-interactive” receivers are otherwise vulnerable to probing attacks. If a sender can make requests at will, they can learn which bitcoin the receiver owns at no cost. Broadcasting the Original PSBT after some time in the failure case makes incurs sender cost and prevents probing.
  ///
  /// Call this after checking downstream.
  Future<FfiV2MaybeInputsOwned> checkBroadcastSuitability(
          {BigInt? minFeeRate,
          required FutureOr<bool> Function(Uint8List) canBroadcast}) =>
      core.instance.api
          .crateApiReceiveFfiV2UncheckedProposalCheckBroadcastSuitability(
              that: this, minFeeRate: minFeeRate, canBroadcast: canBroadcast);

  ///The Sender’s Original PSBT
  Future<Uint8List> extractTxToScheduleBroadcast() => core.instance.api
          .crateApiReceiveFfiV2UncheckedProposalExtractTxToScheduleBroadcast(
        that: this,
      );

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiV2UncheckedProposal &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}
