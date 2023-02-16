FROM golang:1-bullseye as builder
WORKDIR /app
COPY . /app
RUN env GOOS=linux GOARCH=amd64 go build -o cmd/main cmd/main.go

FROM debian:bullseye-slim
ENV TZ="Asia/Jakarta"
WORKDIR /app/
RUN set -x && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*
COPY --from=builder /app/cmd/main /app/main
CMD ["./main"]