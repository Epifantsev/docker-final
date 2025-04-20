FROM golang:1.22.0

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY *.go ./

RUN go mod tidy

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /docker-final .

FROM alpine:latest

CMD ["/docker-final"]