.PHONY: default server client deps fmt clean all release-all assets client-assets server-assets contributors
export GOPATH:=$(shell go env GOPATH)
export BUILDTAGS=debug
export OS=$(os)

default: all

deps: assets
	cd src/ngrok && $(MAKE) deps

server: deps
	cd src/ngrok && $(MAKE) server

fmt:
	cd src/ngrok && $(MAKE) fmt

client: deps
	cd src/ngrok && $(MAKE) client

assets: client-assets server-assets

bin/go-bindata:
	GOOS="" GOARCH="" go get github.com/jteeuwen/go-bindata/go-bindata

client-assets: bin/go-bindata
	go-bindata -nomemcopy -pkg=assets -tags=$(BUILDTAGS) \
		-debug=$(if $(findstring debug,$(BUILDTAGS)),true,false) \
		-o=src/ngrok/client/assets/assets_$(BUILDTAGS).go \
		assets/client/...

server-assets: bin/go-bindata
	go-bindata -nomemcopy -pkg=assets -tags=$(BUILDTAGS) \
		-debug=$(if $(findstring debug,$(BUILDTAGS)),true,false) \
		-o=src/ngrok/server/assets/assets_$(BUILDTAGS).go \
		assets/server/...

release-client: export BUILDTAGS=release
release-client: client

release-server: export BUILDTAGS=release
release-server: server

release-all: fmt release-client release-server

all: fmt client server

clean:
	cd src/ngrok && $(MAKE) clean
	rm -rf src/ngrok/client/assets/ src/ngrok/server/assets/
	rm -rf src/ngrok/ngrok?

contributors:
	echo "Contributors to ngrok, both large and small:\n" > CONTRIBUTORS
	git log --raw | grep "^Author: " | sort | uniq | cut -d ' ' -f2- | sed 's/^/- /' | cut -d '<' -f1 >> CONTRIBUTORS
