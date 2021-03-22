.PHONY: deps server clean client fmt

deps:
	go mod tidy
	go mod download

server:
	go build -tags '$(BUILDTAGS)' -o ngrokd ngrok/main/ngrokd

client:
	go build -tags '$(BUILDTAGS)' -o ngrok ngrok/main/ngrok

fmt:
	go fmt ./...

clean:
	go clean -modcache