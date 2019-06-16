#!/bin/sh
set -e

install -o root -g root -m 644 /inject/postfix/vmailbox /etc/postfix/vmailbox
