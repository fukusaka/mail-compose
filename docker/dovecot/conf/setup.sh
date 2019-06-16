#!/bin/sh
set -e

TARGETS="
dovecot/conf.d/10-ssl.conf
dovecot/conf.d/10-auth.conf
dovecot/conf.d/10-mail.conf
dovecot/conf.d/10-logging.conf
dovecot/conf.d/10-master.conf
dovecot/conf.d/auth-passwdfile.conf.ext
"

NAMES="
SSL
SSL_CERT
SSL_KEY
AUTH_MECHANISMS
AUTH_SCHEME
USERNAME_FORMAT
DISABLE_PLAINTEXT_AUTH
SMTP_AUTH_TYPE
SMTP_AUTH_PATH
SMTP_AUTH_PORT
LMTP_TYPE
LMTP_PATH
LMTP_PORT
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

if [ -f /setup_local.sh ]; then
   . /setup_local.sh
fi
