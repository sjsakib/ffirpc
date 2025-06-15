library grpc_ffi_client;

import 'dart:async';
import 'dart:ffi' as ffi;
import "package:ffi/ffi.dart";
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';

typedef InvokeC = ffi.Void Function(
    ffi.Pointer<Utf8> path,
    ffi.Pointer<ffi.Uint8> input,
    ffi.Int length,
    ffi.Pointer<ffi.Pointer<ffi.Uint8>> output,
    ffi.Pointer<ffi.Int> outLen);

typedef Invoke = void Function(ffi.Pointer<Utf8> path, ffi.Pointer<ffi.Uint8> input,
    int length, ffi.Pointer<ffi.Pointer<ffi.Uint8>> output, ffi.Pointer<ffi.Int> outLen);

class FfiClientCall<Q, R> extends ClientCall<Q, R> {
  final ClientMethod<Q, R> method;
  final CallOptions options;
  final Stream<Q> requests;
  final StreamController<R> _responses = StreamController<R>();

  FfiClientCall(this.method, this.requests, this.options)
      : super(method, requests, options);

  void send(Invoke invoke) async {
    try {
      final request = await requests.first;

      final reqBytes = method.requestSerializer(request);

      final reqPtr = malloc.allocate<ffi.Uint8>(reqBytes.length);

      for (int i = 0; i < reqBytes.length; i++) {
        reqPtr[i] = reqBytes[i];
      }

      final resPtrPtr = malloc.allocate<ffi.Pointer<ffi.Uint8>>(1);
      final resLenPtr = malloc.allocate<ffi.Int>(1);

      final path = method.path.toNativeUtf8();

      invoke(path, reqPtr, reqBytes.length, resPtrPtr, resLenPtr);

      malloc.free(reqPtr);

      final resLen = resLenPtr.value;
      final resBytes = resPtrPtr.value.asTypedList(resLen);

      malloc.free(resPtrPtr);
      malloc.free(resLenPtr);

      final response = method.responseDeserializer(resBytes);

      _responses.add(response);
      _responses.close();
    } catch (e) {
      _responses.addError(GrpcError.internal(e.toString()));
    }
  }

  @override
  Future<void> cancel() async {
    _responses.close();
  }

  @override
  Stream<R> get response => _responses.stream;
}

class FfiClientChannel extends ClientChannelBase {
  late Invoke _invoke;

  FfiClientChannel({String libPath = 'lib'}) {
    final dylib = ffi.DynamicLibrary.open(libPath);
    _invoke = dylib.lookupFunction<InvokeC, Invoke>('Invoke');
  }

  @override
  ClientConnection createConnection() {
    return _FfiClientConnection();
  }

  @override
  ClientCall<Q, R> createCall<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
  ) {
    final call = FfiClientCall(method, requests, options);

    call.send(this._invoke);

    return call;
  }
}

class _FfiClientConnection implements ClientConnection {
  _FfiClientConnection();

  @override
  String get authority => 'localhost';

  @override
  String get scheme => 'ffi';

  @override
  void dispatchCall(ClientCall call) {}

  @override
  GrpcTransportStream makeRequest(String path, Duration? timeout,
      Map<String, String> metadata, ErrorHandler onRequestFailure,
      {required CallOptions callOptions}) {
    throw UnimplementedError('FFI transport does not use makeRequest');
  }

  @override
  Future<void> shutdown() async {}

  @override
  Future<void> terminate() async {}

  @override
  set onStateChanged(void Function(ConnectionState) callback) {}
}
