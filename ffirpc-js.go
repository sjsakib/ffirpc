//go:build js

package ffirpc

import (
	"context"
	"log"
	"syscall/js"

	"google.golang.org/grpc"
	"google.golang.org/protobuf/proto"
)

type Server struct {
	service any
	Methods map[string]grpc.MethodDesc
}

var server *Server

func NewServer() *Server {
	return &Server{
		Methods: make(map[string]grpc.MethodDesc),
	}
}

func (s *Server) RegisterService(sd *grpc.ServiceDesc, service any) {
	s.service = service

	server = s

	for _, method := range sd.Methods {
		path := "/" + sd.ServiceName + "/" + method.MethodName
		s.Methods[path] = method
	}

	select {}
}

func Invoke(this js.Value, args []js.Value) any {
	path := args[0].String()

	inputJsBytes := args[1]
	length := inputJsBytes.Get("byteLength").Int()

	input := make([]byte, length)
	js.CopyBytesToGo(input, inputJsBytes)

	ctx := context.Background()

	// Use the global server variable that was set up in RegisterService
	method := server.Methods[path]

	rsp, err := method.Handler(server.service, ctx, func(req any) error {
		proto.Unmarshal(input, req.(proto.Message))
		return nil
	}, nil)

	if err != nil {
		log.Printf("Failed to handle request: %v", err)
		return nil
	}

	outputBytes, err := proto.Marshal(rsp.(proto.Message))
	if err != nil {
		log.Printf("Failed to marshal response: %v", err)
		return nil
	}

	jsArray := js.Global().Get("Uint8Array").New(len(outputBytes))
	js.CopyBytesToJS(jsArray, outputBytes)

	return jsArray
}

func init() {

	js.Global().Set("invoke", js.FuncOf(Invoke))
}
