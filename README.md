Intended to provide transparent tcp-mode haproxy for docker containers in the same network

Utilize the feature by setting `source 0.0.0.0 usesrc clientip` in the backend while using `mode tcp` and making the backend server(s) use the haproxy container as its default gateway.

This will preserve the source IP for load-balanced packets to that backend

- [github](https://github.com/RaderSolutions/docker-haproxy)
- [docker hub](https://hub.docker.com/r/radersolutions/haproxy/)
