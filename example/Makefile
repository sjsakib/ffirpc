proto-gen:
	protoc --proto_path=. --go_out=. --go-grpc_out=. example.proto

proto-gen-dart:
	@mkdir -p ./dart-consumer/proto-gen
	@protoc --proto_path=. --dart_out=grpc:./dart-consumer/proto-gen/ example.proto

build:
	@echo "Building C shared binary"
	@CGO_ENABLED=1 go build -buildmode=c-shared main.go


	@echo "Copying binary to consumers"
	@mkdir -p ./dart-consumer/bin
	@cp main ./dart-consumer/bin

	@echo "Done"



