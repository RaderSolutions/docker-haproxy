This is an haproxy image with bundled fail2ban.

fail2ban can be customized however one would like by symlinking a custom folder struture to `/etc/fail2ban`, but by default it includes a configuration that gets ban list from the file at ` /opt/logdistro/logs/newbans.log`. This file's format needs to match the format defined in `newbans.conf`

Source links:
- [github](https://github.com/RaderSolutions/docker-haproxy)
- [docker hub](https://hub.docker.com/r/radersolutions/haproxy/)
