#!/bin/sh
set -e

/setup.sh

if [ $(id -u vmail) != $VMAIL_UID ]; then
    usermod -u $VMAIL_UID vmail
fi

if [ $(id -g vmail) != $VMAIL_GID ]; then
    groupmod -g $VMAIL_GID vmail
fi

unset GENERATE_DOVECOT_USERS EXAMPLE_USER EXAMPLE_PASS VMAIL_UID VMAIL_GID
unset SSL SSL_CERT SSL_KEY AUTH_MECHANISMS DISABLE_PLAINTEXT_AUTH

exec /usr/sbin/dovecot -F
