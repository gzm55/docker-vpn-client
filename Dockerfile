FROM jeanblanchard/alpine-glibc
MAINTAINER James Z.M. Gao <gaozm55@gmail.com>

# install pptpclient from test repository
# fix ip command location
RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk --update upgrade && \
    apk add pptpclient@testing && \
    ln -s "$(which ip)" /usr/sbin/ip && \
    rm -rf /var/cache/apk/* /tmp/*

COPY content /

ENTRYPOINT ["/entrypoint.sh"]
