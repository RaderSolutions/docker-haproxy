FROM haproxy:latest

RUN apt update && apt install -y fail2ban iptables && rm -rf /var/lib/apt/lists/* && rm /etc/fail2ban/filter.d/*.conf


# fail2ban
COPY ./fail2ban/action.d/*.conf /etc/fail2ban/action.d/
# COPY ./fail2ban/jail.d/*.conf /etc/fail2ban/jail.d/
COPY ./fail2ban/filter.d/*.conf /etc/fail2ban/filter.d/
# COPY ./fail2ban/fail2ban.d/*.conf /etc/fail2ban/fail2ban.d/
COPY ./fail2ban/jail.local /etc/fail2ban/jail.local
RUN rm /etc/fail2ban/jail.d/defaults-debian.conf && mkdir -p /var/run/fail2ban

COPY docker-entrypoint.sh /
RUN ["chmod", "a+x", "/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]

