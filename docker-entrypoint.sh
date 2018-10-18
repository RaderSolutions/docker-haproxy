#!/bin/sh

set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- haproxy "$@"
fi

if [ "$1" = 'haproxy' ]; then
	# if the user wants "haproxy", let's use "haproxy-systemd-wrapper" instead so we can have proper reloadability implemented by upstream
	shift # "haproxy"
	set -- "$(which haproxy-systemd-wrapper)" -p /run/haproxy.pid "$@"
fi

#set_up

exec "$@"

exec "haproxy -f /usr/local/etc/haproxy/haproxy.cfg"
exec "fail2ban-client -b start"

exec "tail -f /var/log/fail2ban.log /var/log/messages"