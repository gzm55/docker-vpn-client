# docker-vpn-client

VPN clients in docker. Now support pptp and openconect client.
It starts a persist pptp tunnel and adds routing rules.

Run it in bash like this:

```Bash
# print help message
docker run --rm gzm55/vpn-client --help

# start a pptp tunnel
VPN_ROUTING_IPS="172.0.0.0/8 www.google.com"
VPN_PASSOWRD=xxx
#VPN_DEBUG=y

docker run --net=host \
           --privileged=true \
           --device=/dev/ppp \
           --cap-add=NET_ADMIN \
           --name pptp-tunnel-$VPN_SERVER \
           -e VPN_ROUTING_IPS="$VPN_ROUTING_IPS" \
           -e VPN_DEBUG="$VPN_DEBUG" \
           --env-file <(cat <<-END
		VPN_PASSWORD=$VPN_PASSOWRD
		END
           ) \
           --detach \
           gzm55/vpn-client pptp <server-domain-or-ip> <user> [<pppd-options>]

#view openconnect help
docker run -it --rm gzm55/vpn-client openconect --help

# start a openconnect tunnel

VPN_OPENCONNECT_COOKIE=yyy
docker run --net=host \
           --privileged=true \
           --device=/dev/net/tun \
           --cap-add=NET_ADMIN \
           --name openconnect-tunnel-$VPN_SERVER \
           -e VPN_DEBUG="$VPN_DEBUG" \
           --env-file <(cat <<-END
		VPN_PASSWORD=$VPN_PASSOWRD
		VPN_OPENCONNECT_COOKIE=$VPN_OPENCONNECT_COOKIE
		END
           ) \
           --detach \
           gzm55/vpn-client openconnect [<openconnect-options>] <server-domain-or-ip>
```

Accepted docker environment variables for vpn client:

* VPN_ROUTING_IPS: [pptp] space seperated string, each like '172.0.0.0/8', 'www.google.com' or 1.2.3.4
* VPN_DEBUG: [pptp] no empty string will enable debug option for pppd
* VPN_PASSOWRD: [all] login password
* VPN_OPENCONNECT_COOKIE: [openconnect] login cookie
