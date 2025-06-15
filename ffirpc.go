//go:build cgo

package ffirpc

import "C"

import (
	"context"
	"log"
	"unsafe"

	"google.golang.org/grpc"
	"google.golang.org/protobuf/proto"
)

type Server struct {
	service      any
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
}

//export Invoke
func Invoke(path *C.char, input *C.uchar, length C.int, output **C.uchar, outLen *C.int) {
	bytes := C.GoBytes(unsafe.Pointer(input), length)

	goPath := C.GoString(path)

	ctx := context.Background()

	method := server.Methods[goPath]

	rsp, err := method.Handler(server.service, ctx, func(req any) error {
		proto.Unmarshal(bytes, req.(proto.Message))
		return nil
	}, nil)

	if err != nil {
		log.Printf("Failed to handle request: %v", err)
		return
	}

	bytes, err = proto.Marshal(rsp.(proto.Message))
	if err != nil {
		log.Printf("Failed to marshal response: %v", err)
		return
	}

	*output = (*C.uchar)(C.CBytes(bytes))
	*outLen = C.int(len(bytes))
}
