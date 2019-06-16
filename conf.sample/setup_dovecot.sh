#!/bin/sh
set -e

install -o root -g root -m 644 /inject/dovecot/users /etc/dovecot/users
