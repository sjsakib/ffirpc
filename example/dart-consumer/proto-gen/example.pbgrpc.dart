//
//  Generated code. Do not modify.
//  source: example.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'example.pb.dart' as $0;

export 'example.pb.dart';

@$pb.GrpcServiceName('ExampleService')
class ExampleServiceClient extends $grpc.Client {
  static final _$getSubtotal = $grpc.ClientMethod<$0.GetSubtotalRequest, $0.GetSubtotalResponse>(
      '/ExampleService/GetSubtotal',
      ($0.GetSubtotalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSubtotalResponse.fromBuffer(value));

  ExampleServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetSubtotalResponse> getSubtotal($0.GetSubtotalRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSubtotal, request, options: options);
  }
}

@$pb.GrpcServiceName('ExampleService')
abstract class ExampleServiceBase extends $grpc.Service {
  $core.String get $name => 'ExampleService';

  ExampleServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetSubtotalRequest, $0.GetSubtotalResponse>(
        'GetSubtotal',
        getSubtotal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSubtotalRequest.fromBuffer(value),
        ($0.GetSubtotalResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetSubtotalResponse> getSubtotal_Pre($grpc.ServiceCall $call, $async.Future<$0.GetSubtotalRequest> $request) async {
    return getSubtotal($call, await $request);
  }

  $async.Future<$0.GetSubtotalResponse> getSubtotal($grpc.ServiceCall call, $0.GetSubtotalRequest request);
}
