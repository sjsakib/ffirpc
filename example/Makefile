proto-gen:
	protoc --proto_path=. --go_out=. --go-grpc_out=. example.proto

proto-gen-dart:
	@mkdir -p ./dart-consumer/proto-gen
	@protoc --proto_path=. --dart_out=grpc:./dart-consumer/proto-gen/ ./example.proto

proto-gen-node:
	@mkdir -p ./node-consumer/proto-gen
	@echo "Generating JavaScript protobuf using ts-proto"
	@protoc \
  --plugin=protoc-gen-ts_proto=$(shell which protoc-gen-ts_proto) \
  --ts_proto_out=./node-consumer/proto-gen \
  --ts_proto_opt=outputServices=grpc-js \
  --proto_path=. \
  ./example.proto

	@echo "Done"

build:
	@echo "Building C shared binary"
	@CGO_ENABLED=1 go build -buildmode=c-shared main.go


	@echo "Copying binary to consumers"
	@mkdir -p ./dart-consumer/bin
	@cp main ./dart-consumer/bin

	@echo "Done"

build-wasm:
	@echo "Building WASM binary"
	@GOOS=js GOARCH=wasm go build -o main.wasm main-wasm.go

	@echo "Copying wasm to consumers"
	@cp main.wasm ./node-consumer/main.wasm
	@echo "Done"
