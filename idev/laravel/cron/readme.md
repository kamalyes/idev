使用：
FROM ccq18/php-cron
COPY ./cron /etc/cron.d/
RUN cat /etc/cron.d/cron >>/var/spool/cron/crontabs/root