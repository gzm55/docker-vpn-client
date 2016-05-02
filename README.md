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
