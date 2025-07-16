proto-gen:
	protoc --proto_path=. --go_out=. --go-grpc_out=. example.proto

proto-gen-dart:
	@mkdir -p ./consumers/dart/proto-gen
	@protoc --proto_path=. --dart_out=grpc:./consumers/dart/proto-gen/ ./example.proto

proto-gen-node:
	@mkdir -p ./consumers/node/proto-gen
	@echo "Generating JavaScript protobuf using ts-proto"
	@protoc \
	--plugin=protoc-gen-ts_proto=$(shell which protoc-gen-ts_proto) \
	--ts_proto_out=./consumers/node/proto-gen \
	--ts_proto_opt=outputServices=grpc-js \
	--proto_path=. \
	--ts_proto_opt=esModuleInterop=true \
	--ts_proto_opt=esModuleInterop=true \

	@echo "Done"

build:
	@echo "Building C shared binary"
	@CGO_ENABLED=1 go build -buildmode=c-shared -o main .


	@echo "Copying binary to consumers"
	@mkdir -p ./consumers/dart/bin
	@cp main ./consumers/dart/bin
	@echo "Success\n"

	@echo "Building WASM binary for node"

	@GOOS=js GOARCH=wasm go build -o main.wasm .

	@echo "Copying wasm to consumers"
	@cp main.wasm ./consumers/node/main.wasm
	@echo "Done"
