FROM alpine:3.16

LABEL maintainer="shoichi.fukusaka@gmail.com"

RUN set -x \
  && apk add --no-cache bash m4 sed tzdata ca-certificates postfix

RUN set -x \
  && mkdir -p /var/spool/postfix/private

COPY conf/init.sh /init.sh
COPY conf/setup.sh /setup.sh
COPY skel /skel
RUN set -x \
  && chmod +x /init.sh /setup.sh \
  && mkdir /inject

EXPOSE 25 587

ENV TZ="Asia/Tokyo"
ENV USE_SUBMISSION=no
ENV SMTP_AUTH=none
ENV SMTP_AUTH_PATH=""
ENV USE_STARTTLS=no
ENV SSL_CERT="/etc/ssl/postfix/server.pem"
ENV SSL_KEY="/etc/ssl/postfix/server.key"
ENV USE_SPF=no
ENV SPF_PATH=unix:private/policy
ENV USE_OPENDKIM=no
ENV OPENDKIM_PATH=inet:opendkim:8891
ENV MAIL_NAME=example.com
ENV MAIL_HOSTNAME=smtp.example.com
ENV VIRTUAL_TRANSPORT=""
ENV VIRTUAL_MAILBOX_DOMAINS=""
ENV LOOKUP_TABLES="virtual vmailbox"
ENV DEBUG_PEER_LIST=""

CMD ["/init.sh"]
