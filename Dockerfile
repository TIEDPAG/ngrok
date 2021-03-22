FROM golang:1.16
COPY ./ /usr/ngrok/
WORKDIR /usr/ngrok
ENV GOPROXY=https://goproxy.cn
RUN make release-all

FROM alpine:latest
WORKDIR /root/
COPY --from=0 /usr/ngrok/src/ngrok/ngrokd .
ENTRYPOINT ["ngrokd"]