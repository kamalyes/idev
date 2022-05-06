#!/bin/bash
docker build --force-rm --no-cache   ccq18/php-fpm:7.1-v2 .
docker push ccq18/php-fpm:7.1-v2