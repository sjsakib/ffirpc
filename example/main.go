//go:build cgo

package main

import "C"

import (
	"log"
	"net"

	"example.com/example/proto-gen/example"
	"github.com/sjsakib/ffirpc"
	"google.golang.org/grpc"
)

func init() {
	exampleService := NewExampleService()

	server := ffirpc.NewServer()
	example.RegisterExampleServiceServer(server, exampleService)

	log.Println("Service registered")
}

func main() { // running like a regular grpc server over tcp
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
