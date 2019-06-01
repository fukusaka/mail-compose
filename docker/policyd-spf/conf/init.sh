#!/bin/sh
set -e

args="$args unix-listen:${POLICYD_PATH},mode=666,unlink-early"
args="$args system:/usr/bin/postfix-policyd-spf-perl"

unset POLICYD_PATH

exec socat $args
