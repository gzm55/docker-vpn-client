#!/bin/sh -el

if [ -z "$*" -o "$1" = "-h" -o "$1" = "--help" ]; then
  # print usage
  echo "docker run <docker-options> <image> [-h|--help] -- print help"
  echo "docker run <docker-options> <image> pptp <options> -- start a pptp tunnel"
  echo "docker run <docker-options> <image> openconnect <options> -- start a anyconnect tunnel"
  echo "docker run <docker-options> <image> shell-command... -- run a shell command"
  exit 0
fi

ENTRYPOINT="/entrypoint-$1"
[ -x "$ENTRYPOINT" ] || ENTRYPOINT="$1"

shift
exec "$ENTRYPOINT" "$@"
