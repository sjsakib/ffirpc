//go:build js

package main

import (
	"log"

	"example.com/example/proto-gen/example"
	"github.com/sjsakib/ffirpc"
)

func main() {
	exampleService := NewExampleService()

	server := ffirpc.NewServer()
	example.RegisterExampleServiceServer(server, exampleService)

	log.Println("WASM service registered")
}
