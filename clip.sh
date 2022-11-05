#!/bin/bash
for i in "$@"
do
  case "$i" in
  (-i|--input|-in)
    tee <&0 | socat - tcp:host.docker.internal:8121
    exit 0
    ;;
  esac
done
