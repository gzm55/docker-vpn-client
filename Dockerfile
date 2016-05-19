FROM alpine:latest
MAINTAINER James Z.M. Gao <gaozm55@gmail.com>

# install vpn clients
# fix ip command location for the pptp client
RUN set -ex \
    && echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk --update upgrade \
    && apk add pptpclient@testing openconnect@testing \
    && ln -s "$(which ip)" /usr/sbin/ip \
    && ln -s "$(which openconnect)" /entrypoint-openconnect \
    && rm -rf /var/cache/apk/* /tmp/*

COPY content /

ENTRYPOINT ["/entrypoint.sh"]
