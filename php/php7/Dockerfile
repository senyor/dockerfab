FROM debian:stretch

# Prepare Debian environment
ENV DEBIAN_FRONTEND noninteractive

# Performance optimization - see https://gist.github.com/jpetazzo/6127116
# this forces dpkg not to call sync() after package extraction and speeds up install
# we don't need an apt cache in a container
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
    && echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Modify the PHP modules below to match your project requirements
RUN apt-get update \
    && apt-get install -y apt-transport-https lsb-release ca-certificates curl unzip \
    && curl -sS https://packages.sury.org/php/apt.gpg > /etc/apt/trusted.gpg.d/php.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get install -y \
        php7.1-cli \
        php7.1-fpm \
        php7.1-imagick \
        php7.1-intl \
        php7.1-mcrypt \
        php7.1-mysql \
    && rm -rf /var/lib/apt/lists/*

ENV COMPOSER_ALLOW_SUPERUSER=1

COPY image-files/ /

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin \
    && composer global require "fxp/composer-asset-plugin" --optimize-autoloader \
    && composer global dumpautoload --optimize \
    && composer clear-cache \
    && chmod 700 \
        /usr/local/bin/docker-entrypoint.sh \
        /usr/local/bin/docker-run.sh \
        /usr/local/bin/composer

WORKDIR /app

#RUN service php7.1-fpm start \
#    && service php7.1-fpm stop

# Startup script for FPM
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["docker-run.sh"]


