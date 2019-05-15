FROM alpine:3.9

LABEL maintainer="shoichi.fukusaka@gmail.com"

ARG VMAIL_UID=1000
ARG VMAIL_GID=1000

RUN set -x \
  && apk add --no-cache bash m4 sed tzdata shadow ca-certificates dovecot dovecot-lmtpd

RUN set -x \
  && addgroup -g ${VMAIL_GID} vmail \
  && adduser -S -G vmail -u ${VMAIL_UID} -h /var/mail vmail \
  && mkdir -p /var/spool/postfix/private

COPY conf/init.sh /init.sh
COPY conf/setup.sh /setup.sh
COPY skel /skel
RUN set -x \
  && chmod +x /init.sh /setup.sh \
  && mkdir /inject

EXPOSE 143 993 24 588

ENV TZ="Asia/Tokyo"
ENV VMAIL_UID=${VMAIL_UID}
ENV VMAIL_GID=${VMAIL_GID}
ENV SSL=yes
ENV SSL_CERT="/etc/ssl/dovecot/server.pem"
ENV SSL_KEY="/etc/ssl/dovecot/server.key"
ENV AUTH_MECHANISMS="plain login cram-md5"
ENV AUTH_SCHEME="CRAM-MD5"
ENV USERNAME_FORMAT=u
ENV DISABLE_PLAINTEXT_AUTH="no"
ENV SMTP_AUTH_TYPE="none"
ENV SMTP_AUTH_PATH=""
ENV SMTP_AUTH_PORT="588"
ENV LMTP_TYPE="none"
ENV LMTP_PATH="lmtp"
ENV LMTP_PORT="24"

VOLUME /var/mail

CMD ["/init.sh"]
