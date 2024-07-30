FROM crystallang/crystal:latest-alpine AS builder
WORKDIR /app
COPY ./shard.yml ./shard.yml
COPY ./shard.lock ./shard.lock
RUN shards install --production
COPY ./src/ ./src/
RUN crystal build ./src/web_server.cr --static

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app .
CMD [ "/app/web_server" ]
