#!/bin/sh
set -e

tar c -C /inject/opendkim keys | tar x -o -C /etc/opendkim

find /etc/opendkim/keys -exec chown opendkim {} \;
find /etc/opendkim/keys -name '*.private' -type f -exec chmod 660 {} \;
