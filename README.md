Intended to provide transparent tcp-mode haproxy for docker containers in the same network

# Templates pulled from DockerFiles at https://hub.docker.com/r/library/haproxy/

Modified to include a `set_up` function in `docker-entrypoint.sh` to adjust iptables to allow routing traffic