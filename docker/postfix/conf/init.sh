#!/bin/sh
set -e

/setup.sh

/usr/bin/newaliases

for table in ${LOOKUP_TABLES} ; do
    if [ -f "/etc/postfix/${table}" ]; then
        postmap "/etc/postfix/${table}"
    fi
done

unset USE_SUBMISSION
unset SMTP_AUTH
unset SMTP_AUTH_PATH
unset USE_SMTPS
unset SSL_CERT
unset SSL_KEY
unset USE_SPF
unset SPF_PATH
unset USE_OPENDKIM
unset OPENDKIM_PATH
unset MAIL_NAME
unset MAIL_HOSTNAME
unset VIRTUAL_TRANSPORT
unset LOOKUP_TABLES
unset DEBUG_PEER_LIST

exec /usr/sbin/postfix start-fg
