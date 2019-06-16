#!/bin/bash
set -e

TARGETS="
opendkim.conf
"

NAMES="
CANNONICALIZATION
MODE
SUBDOMAINS
SOCKET
KEYTABLE
SIGNINGTABLE
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

for target in ${INJECT} ; do
   if [ -f "/inject/$target" ]; then
       tar c -C /inject $target | tar x -oC /etc
   fi
done
