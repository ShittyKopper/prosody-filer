FROM docker.io/library/golang:1.22-alpine AS builder 

COPY . /repo
WORKDIR /repo
RUN env GOOS=linux GOARCH=arm64 go build -ldflags="-w -s" -o /prosody-filer

FROM scratch

USER 1000:1000
ENTRYPOINT ["/prosody-filer"]

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /prosody-filer /prosody-filer