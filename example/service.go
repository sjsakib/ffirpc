package main

import (
	"context"

	"example.com/example/proto-gen/example"
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
