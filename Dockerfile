FROM haproxy:latest

RUN apt-get update && apt-get install -y iptables fail2ban && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /
RUN ["chmod", "a+x", "/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]

