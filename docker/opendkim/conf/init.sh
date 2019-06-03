#!/bin/sh
set -e

/setup.sh

if [ $(id -u opendkim) != $OPENDKIM_UID ]; then
    usermod -u $OPENDKIM_UID opendkim
fi

if [ $(id -g opendkim) != $OPENDKIM_GID ]; then
    groupmod -g $OPENDKIM_GID opendkim
fi


/usr/sbin/service busybox-syslogd start
/usr/sbin/service opendkim start

/bin/logread -f
