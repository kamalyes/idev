FROM ccq18/php-cli:7.1-v2
COPY ./cron /etc/cron.d/
CMD touch /var/log/cron.log  && crond && tail -f /var/log/cron.log