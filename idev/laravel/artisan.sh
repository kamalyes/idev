#!/usr/bin/env bash
docker run --rm -it -v $PWD:/www  ccq18/php-cli:7.1-v1  /www/artisan $*