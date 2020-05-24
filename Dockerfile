FROM alpine:3.11

RUN apk update && apk upgrade && \
    apk add --no-cache ruby-bundler

COPY entrypoint.sh /entrypoint.sh
COPY fetch.sh /fetch.sh
COPY repack.sh /repack.sh
COPY push.sh /push.sh

ENTRYPOINT ["/entrypoint.sh"]
