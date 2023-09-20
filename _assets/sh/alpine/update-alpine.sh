#!/bin/sh

apk add --no-cache --upgrade apk-tools \
&& apk update --no-cache \
&& apk upgrade --no-cache --available \
&& sync
