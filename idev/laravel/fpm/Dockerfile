FROM php:7.1-fpm-stretch
COPY ext /tmp
ARG PHP_OTHER_EXT="redis-3.1.6 event-2.3.0 swoole-4.0.1"
ARG PHP_CORE_EXT="mbstring mysqli pdo pdo_mysql shmop opcache pcntl posix sockets"
ARG PHP_INSTALL_GD="true"
RUN  cd /tmp && bash install.sh


