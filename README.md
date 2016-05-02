# docker-pptp-client

A pptp client in docker based on alpine. It starts a persist pptp tunnel and adds routing rules.
Run it like this:

```Bash
VPN_SERVER=<server-domain-or-ip>
VPN_USER=<user>
VPN_PASSWORD=<password>
VPN_ROUTING_IPS="172.0.0.0/8 www.google.com"
#VPN_PPP_OPTIONS=
#VPN_DEBUG=y

docker run --net=host \
           --privileged=true \
           --device=/dev/ppp \
           --cap-add=NET_ADMIN \
           --name pptp-tunnel-$VPN_SERVER \
           -e VPN_SERVER="$VPN_SERVER" \
           -e VPN_USER="$VPN_USER" \
           -e VPN_PASSWORD="$VPN_PASSWORD" \
           -e VPN_ROUTING_IPS="$VPN_ROUTING_IPS" \
           -e VPN_PPP_OPTIONS="$VPN_PPP_OPTIONS" \
           -e VPN_DEBUG="$VPN_DEBUG" \
           -d \
           gzm55/pptp-client
```

Accepted docker environment variables:

* VPN_SERVER: server domain or ip
* VPN_USER: user
* VPN_PASSWORD: password
* VPN_ROUTING_IPS: space seperated string, each like '172.0.0.0/8', 'www.google.com' or 1.2.3.4
* VPN_PPP_OPTIONS: space seperated string, passed to `pppd'
* VPN_DEBUG: no empty string will enable debug option for pppd
