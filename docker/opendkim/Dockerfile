FROM debian:stretch-slim

LABEL maintainer="shoichi.fukusaka@gmail.com"

ARG OPENDKIM_UID=1000
ARG OPENDKIM_GID=1000

RUN set -x \
  && apt update \
  && apt install --yes busybox-syslogd bash m4 procps tree opendkim opendkim-tools \
  && rm -rf /var/lib/apt/lists/* \
  && usermod -u ${OPENDKIM_UID} opendkim \
  && groupmod -g ${OPENDKIM_GID} opendkim

RUN mkdir -p /etc/opendkim/keys

COPY conf/init.sh /init.sh
COPY conf/setup.sh /setup.sh
RUN chmod +x /init.sh /setup.sh
COPY skel /skel

ENV OPENDKIM_UID=${OPENDKIM_UID}
ENV OPENDKIM_GID=${OPENDKIM_GID}
ENV TZ="Asia/Tokyo"
ENV CANNONICALIZATION="simple"
ENV MODE="sv"
ENV SUBDOMAINS="no"
ENV SOCKET="local:/var/run/opendkim/opendkim.sock"
ENV KEYTABLE="/etc/opendkim/KeyTable"
ENV SIGNINGTABLE="/etc/opendkim/SigningTable"
ENV INJECT="opendkim"

EXPOSE 8891

CMD ["/init.sh"]
