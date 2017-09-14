#!/bin/sh

# main settings pulled from here
# https://github.com/tombull/haproxy/blob/master/docker-entrypoint.sh
#function set_up {
  sysctl net.ipv4.ip_nonlocal_bind | grep "net.ipv4.ip_nonlocal_bind\s*=\s*1" > /dev/null || echo "Setting ipv4.ip_nonlocal_bind" && INITIAL_IP_NONLOCAL_SETTING="0" && echo "1" > /var/proc/sys/net/ipv4/ip_nonlocal_bind
  echo "Creating iptables DIVERT table" && iptables -t mangle -N DIVERT 2> /dev/null
  iptables -t mangle -C PREROUTING -p tcp -m socket -j DIVERT 2> /dev/null || echo "Creating iptables DIVERT rule" && iptables -t mangle -A PREROUTING -p tcp -m socket -j DIVERT
  iptables -t mangle -C DIVERT -j MARK --set-mark 1 2> /dev/null || echo "Creating iptables mark rule" && iptables -t mangle -A DIVERT -j MARK --set-mark 1
  iptables -t mangle -C DIVERT -j ACCEPT 2> /dev/null || echo "Creating iptables rule ACCEPT for DIVERT" && iptables -t mangle -A DIVERT -j ACCEPT
  ip rule show | grep "from all fwmark 0x1 lookup 100" > /dev/null || echo "Creating ip rule for marked packets" && ip rule add fwmark 1 lookup 100
  [ $(ip route show table 100 | wc -l) -lt 1 ] && echo "Creating ip route for marked packets" && ip route add local 0.0.0.0/0 dev lo table 100
#}

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