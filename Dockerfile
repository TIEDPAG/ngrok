FROM golang:1.16 AS builder
COPY ./ /usr/ngrok/
WORKDIR /usr/ngrok
ENV GOPROXY=https://goproxy.cn
RUN make release-server

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /usr/ngrok/src/ngrok/ngrokd .
COPY --from=builder /usr/ngrok/assets /usr/ngrok/assets
ENTRYPOINT ["./ngrokd"]
