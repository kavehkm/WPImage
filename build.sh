#!/usr/bin/env bash

docker build -f 7.4/Dockerfile -t kavehkm/wp6:php7.4-fpm-1001 .

docker build -f 8.1/Dockerfile -t kavehkm/wp6:php8.1-fpm-1001 .