//go:build cgo

package main

import "C"

import (
	"context"
	"log"
	"net"

	"example.com/example/proto-gen/example"
	"github.com/sjsakib/ffirpc"
	"google.golang.org/grpc"
)

type ExampleService struct {
	example.ExampleServiceServer
}

func NewExampleService() *ExampleService {
	return &ExampleService{}
}

func (s *ExampleService) GetSubtotal(ctx context.Context, req *example.GetSubtotalRequest) (*example.GetSubtotalResponse, error) {
	subtotal := 0.0
	for _, product := range req.Products {
		subtotal += product.Price
	}
	return &example.GetSubtotalResponse{
		Subtotal: subtotal,
	}, nil
}

func init() {
	exampleService := NewExampleService()

	server := ffirpc.NewServer()
	example.RegisterExampleServiceServer(server, exampleService)

	log.Println("Service registered")
}

func main() {
	server := grpc.NewServer()

	exampleServer := NewExampleService()
	example.RegisterExampleServiceServer(server, exampleServer)

	con, err := net.Listen("tcp", ":8080")

	if err != nil {
		log.Fatal("Failed to listen", err)
	}

	err = server.Serve(con)

	if err != nil {
		log.Fatal("Failed to start grpc server", err)
	}
}
