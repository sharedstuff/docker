#!/bin/sh

apk add docker docker-compose
rc-update add docker default
service docker start
