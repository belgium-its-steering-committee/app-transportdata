FROM alpine:3.23

RUN apk add docker-cli-compose
COPY crontab /etc/crontabs/root

CMD ["busybox", "crond", "-f", "-L", "/dev/stdout"]
