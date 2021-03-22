.PHONY: deps server clean client fmt

deps:
	go mod tidy
	go mod download

server:
	CGO_ENABLE=0 GOOS=$(OS) go build -tags '$(BUILDTAGS)' -o ngrokd ngrok/main/ngrokd

client:
	CGO_ENABLE=0 GOOS=$(OS) go build -tags '$(BUILDTAGS)' -o ngrok ngrok/main/ngrok

fmt:
	go fmt ./...

clean:
	go clean -modcache