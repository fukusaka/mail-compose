#!/bin/sh
set -e

TARGETS="
postfix/main.cf
postfix/master.cf
"

NAMES="
USE_SUBMISSION
SMTP_AUTH
SMTP_AUTH_PATH
USE_STARTTLS
SSL_CERT
SSL_KEY
USE_SPF
SPF_PATH
USE_OPENDKIM
OPENDKIM_PATH
MAIL_NAME
MAIL_HOSTNAME
VIRTUAL_TRANSPORT
VIRTUAL_MAILBOX_DOMAINS
DEBUG_PEER_LIST
"


cd /skel

(
    echo -e "divert(-1)dnl\nchangequote(\`[[', \`]]')"
    for name in ${NAMES}; do
        echo "define([[__${name}__]],[["$(eval echo '$'{${name}})"]])"
    done
    echo 'divert[[]]dnl'
) > define.m4

for target in ${TARGETS} ; do
   m4 define.m4 ${target} > /etc/${target}
done

for table in ${LOOKUP_TABLES} ; do
    if [ ! -f "/etc/postfix/${table}" ]; then
        touch "/etc/postfix/${table}"
    fi
done

if [ -f /setup_local.sh ]; then
   . /setup_local.sh
fi
