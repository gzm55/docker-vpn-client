# docker-vpn-client

VPN clients in docker. Now support pptp and openconect client.
It starts a persist pptp tunnel and adds routing rules.

Run it like this:

```Bash
# print help message
docker run -it --rm gzm55/vpn-client --help

# start a pptp tunnel
VPN_ROUTING_IPS="172.0.0.0/8 www.google.com"
#VPN_DEBUG=y

echo password |
docker run -i
           --net=host \
           --privileged=true \
           --device=/dev/ppp \
           --cap-add=NET_ADMIN \
           --name pptp-tunnel-$VPN_SERVER \
           -e VPN_ROUTING_IPS="$VPN_ROUTING_IPS" \
           -e VPN_DEBUG="$VPN_DEBUG" \
           -d \
           gzm55/vpn-client <server-domain-or-ip> <suer> [<pppd-options>]

#view openconnect help
docker run -it --rm gzm55/vpn-client openconect --help
```

Accepted docker environment variables for vpn client:

* VPN_ROUTING_IPS: space seperated string, each like '172.0.0.0/8', 'www.google.com' or 1.2.3.4
* VPN_DEBUG: no empty string will enable debug option for pppd
