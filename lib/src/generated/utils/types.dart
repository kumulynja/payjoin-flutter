// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

class Headers {
  final Map<String, String> map;

  const Headers({
    required this.map,
  });

  @override
  int get hashCode => map.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Headers && runtimeType == other.runtimeType && map == other.map;
}

enum Network {
  ///Bitcoin’s testnet
  testnet,

  ///Bitcoin’s regtest
  regtest,

  ///Classic Bitcoin
  bitcoin,

  ///Bitcoin’s signet
  signet,
  ;
}

/// A reference to a transaction output.
class OutPoint {
  /// The referenced transaction's txid.
  final String txid;

  /// The index of the referenced output in its transaction's vout.
  final int vout;

  const OutPoint({
    required this.txid,
    required this.vout,
  });

  @override
  int get hashCode => txid.hashCode ^ vout.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutPoint &&
          runtimeType == other.runtimeType &&
          txid == other.txid &&
          vout == other.vout;
}

class TxOut {
  /// The value of the output, in satoshis.
  final BigInt value;

  /// The address of the output.
  final Uint8List scriptPubkey;

  const TxOut({
    required this.value,
    required this.scriptPubkey,
  });

  @override
  int get hashCode => value.hashCode ^ scriptPubkey.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TxOut &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          scriptPubkey == other.scriptPubkey;
}
