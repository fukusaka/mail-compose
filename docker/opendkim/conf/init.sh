#!/bin/sh
set -e

if [ $(id -u opendkim) != $OPENDKIM_UID ]; then
    usermod -u $OPENDKIM_UID opendkim
fi

if [ $(id -g opendkim) != $OPENDKIM_GID ]; then
    groupmod -g $OPENDKIM_GID opendkim
fi

/setup.sh

unset OPENDKIM_UID
unset OPENDKIM_GID
unset CANNONICALIZATION
unset MODE
unset SUBDOMAINS
unset SOCKET
unset KEYTABLE
unset SIGNINGTABLE

/usr/sbin/service busybox-syslogd start
/usr/sbin/service opendkim start

/bin/logread -f
