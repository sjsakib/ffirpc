import 'proto-gen/example.pbgrpc.dart';
import "package:grpc_ffi_client/lib.dart";

void main() async {
  final channel = FfiClientChannel(libPath: 'bin/main');

  final client = ExampleServiceClient(channel);

  final request = GetSubtotalRequest(
    products: [
      Product(name: 'Product 1', price: 100),
      Product(name: 'Product 2', price: 200),
      Product(name: 'Product 3', price: 300),
    ],
  );
  print("Sending request");
  final response = await client.getSubtotal(request);

  print("Got response");
  print(response);
}
