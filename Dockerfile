# Build stage
FROM golang:1.22 AS builder

RUN git clone https://github.com/rakyll/hey.git /app
WORKDIR /app
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go install

# Final stage
FROM alpine:latest

COPY --from=builder /go/bin/hey /hey

ENTRYPOINT ["/hey"]
