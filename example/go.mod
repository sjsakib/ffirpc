module example.com/example

go 1.23.6

replace github.com/sjsakib/ffirpc => ../

require (
	golang.org/x/net v0.41.0 // indirect
	golang.org/x/sys v0.33.0 // indirect
	golang.org/x/text v0.26.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20250603155806-513f23925822 // indirect
	google.golang.org/grpc v1.73.0 // indirect
	google.golang.org/protobuf v1.36.6 // indirect
	github.com/sjsakib/ffirpc v0.0.0-00010101000000-000000000000 // direct
)
