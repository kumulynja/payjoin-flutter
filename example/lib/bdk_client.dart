import 'dart:typed_data';

import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter/cupertino.dart';

class BdkClient {
  // Bitcoin core credentials
  // String localEsploraUrl = 'http://0.0.0.0:30000';

  late Wallet wallet;
  late Blockchain blockchain;
  final String descriptor;
  final String? _changeDescriptor;
  final Network network;

  BdkClient(this.descriptor, this.network, {String? changeDescriptor})
      : _changeDescriptor = changeDescriptor;

  Future<void> restoreWallet() async {
    try {
      await initBlockchain();
      wallet = await Wallet.create(
        descriptor:
            await Descriptor.create(descriptor: descriptor, network: network),
        changeDescriptor: _changeDescriptor != null
            ? await Descriptor.create(
                descriptor: _changeDescriptor, network: network)
            : null,
        network: network,
        databaseConfig: const DatabaseConfig.memory(),
      );
      debugPrint(getNewAddress().address.toString());
    } on Exception {
      rethrow;
    }
  }

  Future<void> initBlockchain() async {
    // String esploraUrl =
    //     Platform.isAndroid ? 'http://10.0.2.2:30000' : localEsploraUrl;
    try {
      blockchain = await Blockchain.create(
          config: BlockchainConfig.esplora(
              config: EsploraConfig(
                  baseUrl: "https://mutinynet.ltbl.io/api",
                  stopGap: BigInt.from(144))));
    } on Exception {
      rethrow;
    }
  }

  AddressInfo getNewAddress() {
    final res = wallet.getAddress(addressIndex: const AddressIndex.increase());
    return res;
  }

  List<TransactionDetails> listTransactions() {
    final res = wallet.listTransactions(includeRaw: true);
    return res;
  }

  Future<String> processPsbt(
    String psbtBase64,
  ) async {
    debugPrint('Signing PSBT: $psbtBase64');
    final psbt = await PartiallySignedTransaction.fromString(psbtBase64);
    await wallet.sign(
        psbt: psbt,
        signOptions: const SignOptions(
          trustWitnessUtxo: true,
          allowAllSighashes: false,
          removePartialSigs: true,
          tryFinalize: true,
          signWithTapInternalKey: true,
          allowGrinding: false,
        ));
    debugPrint('Signed PSBT: ${psbt.asString()}');
    return psbt.asString();
  }

  Future<String> createPsbt(String addressStr, int amount, int fee) async {
    try {
      final txBuilder = TxBuilder();
      final address = await Address.fromString(s: addressStr, network: network);
      final script = address.scriptPubkey();
      final (psbt, _) = await txBuilder
          .addRecipient(script, BigInt.from(amount))
          .feeAbsolute(BigInt.from(fee))
          .finish(wallet);
      debugPrint('Created PSBT: ${psbt.asString()}');
      await wallet.sign(
          psbt: psbt,
          signOptions: const SignOptions(
            trustWitnessUtxo: true,
            allowAllSighashes: false,
            removePartialSigs: true,
            tryFinalize: true,
            signWithTapInternalKey: true,
            allowGrinding: false,
          ));
      debugPrint('Signed original PSBT: ${psbt.asString()}');
      return psbt.asString();
    } on Exception {
      rethrow;
    }
  }

  int getBalance() {
    final balance = wallet.getBalance();
    final res = "Total Balance: ${balance.total.toString()}";
    debugPrint(res);
    return balance.total.toInt();
  }

  Future<String> broadcastPsbt(PartiallySignedTransaction psbt) async {
    try {
      final tx = psbt.extractTx();
      final txid = await blockchain.broadcast(transaction: tx);
      return txid;
    } catch (e) {
      rethrow;
    }
  }

  bool getAddressInfo(ScriptBuf script) {
    final res = wallet.isMine(script: script);
    return res;
  }

  Future<void> syncWallet() async {
    wallet.sync(blockchain: blockchain);
  }

  List<LocalUtxo> listUnspent() {
    return wallet.listUnspent();
  }

  bool isOwned(Uint8List bytes) {
    final script = ScriptBuf(bytes: bytes);
    return wallet.isMine(script: script);
  }
}
