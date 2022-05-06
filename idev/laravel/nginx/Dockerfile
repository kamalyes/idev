FROM nginx:1.13-alpine

ADD  nginx.conf      /etc/nginx/nginx.conf
ADD  sites-enabled/*    /etc/nginx/conf.d/
RUN   adduser -D -H -u 1000 -s /bin/bash www-data \
    && mkdir -p /opt/htdocs && mkdir /opt/log && mkdir /opt/log/nginx \
    && chown -R www-data.www-data /opt/htdocs /opt/log
#VOLUME ["/opt"]