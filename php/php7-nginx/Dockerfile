FROM senyor/php7:latest

# Install nginx
RUN apt-get update \
    && apt-get install -y --allow-unauthenticated nginx-full cron supervisor \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add configuration files
COPY image-files/ /

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log \
 && ln -sf /usr/sbin/cron /usr/sbin/crond

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/nginx-php-fpm.conf"]

RUN usermod -aG www-data nginx

EXPOSE 80 443




