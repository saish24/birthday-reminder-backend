FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o birthday-reminder-backend .

FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/birthday-reminder-backend .

EXPOSE 8089

CMD [ "./birthday-reminder-backend" ]