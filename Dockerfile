FROM golang:alpine as builder
WORKDIR /
RUN apk --no-cache add git && \
    git clone https://github.com/padiazg/grafana_bot.git && \
    cd grafana_bot && \
    go get -d -v && \
    CGO_ENABLED=0 GOOS=linux go build -v -a -installsuffix cgo -o grafana_bot

FROM alpine
COPY --from=builder /grafana_bot/grafana_bot /
RUN apk add --no-cache ca-certificates
EXPOSE 9087
ENTRYPOINT ["/grafana_bot"]
