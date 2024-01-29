// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.24.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import '../utils/error.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'uri.dart';

// Rust type: RustOpaqueMoi<Arc < payjoin_ffi :: send :: ContextV1 >>
@sealed
class ArcPayjoinFfiSendContextV1 extends RustOpaque {
  ArcPayjoinFfiSendContextV1.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  ArcPayjoinFfiSendContextV1.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount: RustLib.instance.api
        .rust_arc_increment_strong_count_ArcPayjoinFfiSendContextV1,
    rustArcDecrementStrongCount: RustLib.instance.api
        .rust_arc_decrement_strong_count_ArcPayjoinFfiSendContextV1,
    rustArcDecrementStrongCountPtr: RustLib.instance.api
        .rust_arc_decrement_strong_count_ArcPayjoinFfiSendContextV1Ptr,
  );
}

// Rust type: RustOpaqueMoi<Arc < payjoin_ffi :: send :: RequestBuilder >>
@sealed
class ArcPayjoinFfiSendRequestBuilder extends RustOpaque {
  ArcPayjoinFfiSendRequestBuilder.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  ArcPayjoinFfiSendRequestBuilder.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount: RustLib.instance.api
        .rust_arc_increment_strong_count_ArcPayjoinFfiSendRequestBuilder,
    rustArcDecrementStrongCount: RustLib.instance.api
        .rust_arc_decrement_strong_count_ArcPayjoinFfiSendRequestBuilder,
    rustArcDecrementStrongCountPtr: RustLib.instance.api
        .rust_arc_decrement_strong_count_ArcPayjoinFfiSendRequestBuilderPtr,
  );
}

// Rust type: RustOpaqueMoi<Arc < payjoin_ffi :: send :: RequestContext >>
@sealed
class ArcPayjoinFfiSendRequestContext extends RustOpaque {
  ArcPayjoinFfiSendRequestContext.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  ArcPayjoinFfiSendRequestContext.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount: RustLib.instance.api
        .rust_arc_increment_strong_count_ArcPayjoinFfiSendRequestContext,
    rustArcDecrementStrongCount: RustLib.instance.api
        .rust_arc_decrement_strong_count_ArcPayjoinFfiSendRequestContext,
    rustArcDecrementStrongCountPtr: RustLib.instance.api
        .rust_arc_decrement_strong_count_ArcPayjoinFfiSendRequestContextPtr,
  );
}

// Rust type: RustOpaqueMoi<Arc < payjoin_ffi :: send :: v2 :: ContextV2 >>
@sealed
class ArcPayjoinFfiSendV2ContextV2 extends RustOpaque {
  ArcPayjoinFfiSendV2ContextV2.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  ArcPayjoinFfiSendV2ContextV2.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount: RustLib.instance.api
        .rust_arc_increment_strong_count_ArcPayjoinFfiSendV2ContextV2,
    rustArcDecrementStrongCount: RustLib.instance.api
        .rust_arc_decrement_strong_count_ArcPayjoinFfiSendV2ContextV2,
    rustArcDecrementStrongCountPtr: RustLib.instance.api
        .rust_arc_decrement_strong_count_ArcPayjoinFfiSendV2ContextV2Ptr,
  );
}

// Rust type: RustOpaqueMoi<Arc < payjoin_ffi :: uri :: Uri >>
@sealed
class ArcPayjoinFfiUriUri extends RustOpaque {
  ArcPayjoinFfiUriUri.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  ArcPayjoinFfiUriUri.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount: RustLib
        .instance.api.rust_arc_increment_strong_count_ArcPayjoinFfiUriUri,
    rustArcDecrementStrongCount: RustLib
        .instance.api.rust_arc_decrement_strong_count_ArcPayjoinFfiUriUri,
    rustArcDecrementStrongCountPtr: RustLib
        .instance.api.rust_arc_decrement_strong_count_ArcPayjoinFfiUriUriPtr,
  );
}

// Rust type: RustOpaqueMoi<Arc < payjoin_ffi :: uri :: Url >>
@sealed
class ArcPayjoinFfiUriUrl extends RustOpaque {
  ArcPayjoinFfiUriUrl.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  ArcPayjoinFfiUriUrl.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount: RustLib
        .instance.api.rust_arc_increment_strong_count_ArcPayjoinFfiUriUrl,
    rustArcDecrementStrongCount: RustLib
        .instance.api.rust_arc_decrement_strong_count_ArcPayjoinFfiUriUrl,
    rustArcDecrementStrongCountPtr: RustLib
        .instance.api.rust_arc_decrement_strong_count_ArcPayjoinFfiUriUrlPtr,
  );
}

class ContextV1 {
  final ArcPayjoinFfiSendContextV1 field0;

  const ContextV1({
    required this.field0,
  });

  Future<String> processResponse({required List<int> response, dynamic hint}) =>
      RustLib.instance.api.contextV1ProcessResponse(
        that: this,
        response: response,
      );

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContextV1 &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class ContextV2 {
  final ArcPayjoinFfiSendV2ContextV2 field0;

  const ContextV2({
    required this.field0,
  });

  Future<String?> processResponse(
          {required List<int> response, dynamic hint}) =>
      RustLib.instance.api.contextV2ProcessResponse(
        that: this,
        response: response,
      );

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContextV2 &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

///Represents data that needs to be transmitted to the receiver.
///You need to send this request over HTTP(S) to the receiver.
class Request {
  ///URL to send the request to.
  ///
  ///This is full URL with scheme etc - you can pass it right to reqwest or a similar library.
  final Url url;

  ///Bytes to be sent to the receiver.
  ///
  ///This is properly encoded PSBT, already in base64. You only need to make sure Content-Type is text/plain and Content-Length is body.len() (most libraries do the latter automatically).
  final Uint8List body;

  const Request({
    required this.url,
    required this.body,
  });

  @override
  int get hashCode => url.hashCode ^ body.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Request &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          body == other.body;
}

class RequestBuilder {
  final ArcPayjoinFfiSendRequestBuilder field0;

  const RequestBuilder({
    required this.field0,
  });

  Future<RequestBuilder> alwaysDisableOutputSubstitution(
          {required bool disable, dynamic hint}) =>
      RustLib.instance.api.requestBuilderAlwaysDisableOutputSubstitution(
        that: this,
        disable: disable,
      );

  Future<RequestContext> buildNonIncentivizing({dynamic hint}) =>
      RustLib.instance.api.requestBuilderBuildNonIncentivizing(
        that: this,
      );

  Future<RequestContext> buildRecommended(
          {required int minFeeRate, dynamic hint}) =>
      RustLib.instance.api.requestBuilderBuildRecommended(
        that: this,
        minFeeRate: minFeeRate,
      );

  Future<RequestContext> buildWithAdditionalFee(
          {required int maxFeeContribution,
          int? changeIndex,
          required int minFeeRate,
          required bool clampFeeContribution,
          dynamic hint}) =>
      RustLib.instance.api.requestBuilderBuildWithAdditionalFee(
        that: this,
        maxFeeContribution: maxFeeContribution,
        changeIndex: changeIndex,
        minFeeRate: minFeeRate,
        clampFeeContribution: clampFeeContribution,
      );

  static Future<RequestBuilder> fromPsbtAndUri(
          {required String psbtBase64, required Uri uri, dynamic hint}) =>
      RustLib.instance.api.requestBuilderFromPsbtAndUri(
          psbtBase64: psbtBase64, uri: uri, hint: hint);

  static Future<void> newRequestBuilder({dynamic hint}) =>
      RustLib.instance.api.requestBuilderNew(hint: hint);

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestBuilder &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class RequestContext {
  final ArcPayjoinFfiSendRequestContext field0;

  const RequestContext({
    required this.field0,
  });

  Future<RequestContextV1> extractV1({dynamic hint}) =>
      RustLib.instance.api.requestContextExtractV1(
        that: this,
      );

  Future<RequestContextV2> extractV2(
          {required String ohttpProxyUrl, dynamic hint}) =>
      RustLib.instance.api.requestContextExtractV2(
        that: this,
        ohttpProxyUrl: ohttpProxyUrl,
      );

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestContext &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class RequestContextV1 {
  final Request request;
  final ContextV1 contextV1;

  const RequestContextV1({
    required this.request,
    required this.contextV1,
  });

  @override
  int get hashCode => request.hashCode ^ contextV1.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestContextV1 &&
          runtimeType == other.runtimeType &&
          request == other.request &&
          contextV1 == other.contextV1;
}

class RequestContextV2 {
  final Request request;
  final ContextV2 contextV2;

  const RequestContextV2({
    required this.request,
    required this.contextV2,
  });

  @override
  int get hashCode => request.hashCode ^ contextV2.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestContextV2 &&
          runtimeType == other.runtimeType &&
          request == other.request &&
          contextV2 == other.contextV2;
}