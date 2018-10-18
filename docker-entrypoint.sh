#!/bin/sh

set -e

touch  /opt/logdistro/logs/newbans.log

tail -f /var/log/fail2ban.log /opt/logdistro/logs/newbans.log
