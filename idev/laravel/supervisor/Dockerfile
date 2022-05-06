FROM ccq18/php-cli:7.1-v2
RUN apt-get update \
 && apt-get install -y  supervisor  \
 && mkdir -p /var/run/sshd  \
 && mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisord.conf
CMD supervisord -c /etc/supervisord.conf && tail -f /var/log/supervisord.log
