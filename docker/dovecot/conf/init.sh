#!/bin/sh
set -e

if [ $(id -u vmail) != $VMAIL_UID ]; then
    usermod -u $VMAIL_UID vmail
fi

if [ $(id -g vmail) != $VMAIL_GID ]; then
    groupmod -g $VMAIL_GID vmail
fi

/setup.sh

unset VMAIL_UID
unset VMAIL_GID
unset SSL
unset SSL_CERT
unset SSL_KEY
unset AUTH_MECHANISMS
unset AUTH_SCHEME
unset USERNAME_FORMAT
unset DISABLE_PLAINTEXT_AUTH
unset SMTP_AUTH_TYPE
unset SMTP_AUTH_PATH
unset SMTP_AUTH_PORT
unset LMTP_TYPE
unset LMTP_PATH
unset LMTP_PORT

exec /usr/sbin/dovecot -F
