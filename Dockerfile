FROM alpine:latest

WORKDIR /app

RUN apk update \
  && apk add stunnel \
  && chown -R stunnel:stunnel /etc/stunnel \
  && mkdir /run/stunnel \
  && chown -R stunnel:stunnel /run/stunnel \
  && rm -rf /var/cache/apk/* \
  && mv /etc/stunnel/stunnel.conf /etc/stunnel/stunnel.conf.default

COPY entrypoint.sh .

USER stunnel

EXPOSE 143
EXPOSE 110
EXPOSE 25

ENTRYPOINT ["sh", "/app/entrypoint.sh"]
