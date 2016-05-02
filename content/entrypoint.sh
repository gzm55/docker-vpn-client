#!/bin/sh -el

[ -z "$*" ] || exec "$@"

echo "$VPN_USER PPTP $VPN_PASSWORD  *" > /etc/ppp/chap-secrets
unset VPN_PASSWORD
chmod 0600 /etc/ppp/chap-secrets

while read line; do
  eval echo "$line"
done < /etc/ppp/peers/pptp-provider.template > /etc/ppp/peers/pptp-provider

VPN_ROUTING_IPS_VALIDATE=
for i in $VPN_ROUTING_IPS; do
  case $i in
  (default) VPN_ROUTING_IPS_VALIDATE=default
            break
            ;;
  (localhost) ;;
  (*/*) VPN_ROUTING_IPS_VALIDATE="$VPN_ROUTING_IPS_VALIDATE $i" ;;
  (*) for a in $(nslookup $i 2>/dev/null | awk '/^Address / && $3 !~ /:/ { print $3 }'); do
        VPN_ROUTING_IPS_VALIDATE="$VPN_ROUTING_IPS_VALIDATE $a"
      done
      ;;
  esac
done
VPN_ROUTING_IPS=${VPN_ROUTING_IPS_VALIDATE# }

while read line; do
  if [ "${line:0:1}" = '#' ]; then
    echo "$line"
  else
    eval echo "${line//;/\;}"
  fi
done < /etc/ppp/ip-up.template > /etc/ppp/ip-up
chmod +x /etc/ppp/ip-up

if [ -n "$VPN_DEBUG" ]; then
  VPN_PPP_OPTIONS="$VPN_PPP_OPTIONS debug dump logfd 2"
fi

exec pon pptp-provider $VPN_PPP_OPTIONS
