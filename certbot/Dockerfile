FROM alpine:3.12

WORKDIR /app

COPY ./start.sh /app/start.sh

RUN apk add --update --no-cache certbot

CMD ["/bin/sh","start.sh"]
