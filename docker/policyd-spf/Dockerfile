FROM alpine:3.16

LABEL maintainer="shoichi.fukusaka@gmail.com"

RUN set -x \
  && apk add --no-cache bash tzdata postfix-policyd-spf-perl socat

COPY conf/init.sh /init.sh
RUN chmod +x /init.sh

ENV TZ="Asia/Tokyo"
ENV POLICYD_PATH="private/policyd-spf"

CMD ["/init.sh"]
