Intended to provide transparent tcp-mode haproxy for docker containers in the same network

# Templates pulled from DockerFiles at https://hub.docker.com/r/library/haproxy/

Modified to include a `set_up` function in `docker-entrypoint.sh` to adjust iptables to allow routing traffic

Utilize the feature by setting `source 0.0.0.0 usesrc clientip` in the backend while using `mode tcp` and making the backend server(s) use the haproxy container as its default gateway.

This will preserve the source IP for load-balanced packets to that backend