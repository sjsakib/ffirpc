# FFI RPC

A Go library that enables gRPC services to be consumed from multiple programming languages using Foreign Function Interface (FFI) through WebAssembly.

## Overview

FFI RPC allows you to:
- Write gRPC services in Go
- Compile them to WebAssembly or C shared libraries
- Call them from Node.js, Dart, and other languages that support WASM
- Bypass traditional network overhead for local inter-language communication

## Architecture

- **Go Server**: Implements gRPC services with FFI exports
- **WebAssembly/C Shared Library**: Compiles Go code to WASM or shared libraries for cross-platform execution
- **Language Clients**: Native clients that load WASM and invoke functions via FFI

## Project Structure

```
├── ffirpc.go          # Core FFI RPC server implementation
├── ffirpc-js.go       # Core FFI RPC server implementation for JavaScript/WebAssembly
├── clients/           # Client libraries for different languages
│   ├── node/          # Node.js/TypeScript client
│   └── dart/          # Dart client
└── example/           # An example service and its consumers
    ├── example.proto  # Protocol buffer definition
    ├── proto-gen/     # Generated protocol buffer code
    ├── service.go     # Service implementation
    ├── main.go        # Entrypoint for server (C shared library)
    ├── main-wasm.go   # Entrypoint for WebAssembly server
    └── consumers/     # Example client implementations
        ├── node/      # Node.js consumer
        └── dart/      # Dart consumer
```

## Running the example

### Compile the go service
```bash
cd example
make build
```

### Run the dart consumer
```bash
cd example/consumers/dart
dart main.dart
```

### Run the node consumer

Build the node library

```bash
cd clients/node
npm install
npm run build
```

Run the node consumer

```bash
cd example/consumers/node
tsx index.ts
```

