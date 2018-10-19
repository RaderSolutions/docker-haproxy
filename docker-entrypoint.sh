#!/bin/sh

set -e

#haproxy -f /usr/local/etc/haproxy/haproxy.cfg
#fail2ban-client -b start
touch  /opt/logdistro/logs/newbans.log

tail -f /var/log/fail2ban.log /opt/logdistro/logs/newbans.log
