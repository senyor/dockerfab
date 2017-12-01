FROM php:5.6.32-fpm

RUN apt-get update && apt-get upgrade -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpq-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libpng12-dev \
    libmemcached-dev \
    libssl-dev \
    libssl-doc \
    libsasl2-dev \
    zlib1g-dev \
    libicu-dev \
    g++
RUN docker-php-ext-install \
        bz2 \
        iconv \
        mbstring \
        mcrypt \
        mysqli \
        pgsql \
        pdo_mysql \
        pdo_pgsql \
        soap \
        zip && \
    docker-php-ext-configure intl && docker-php-ext-install intl && \
    docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-png-dir=/usr/include/ && docker-php-ext-install gd && \
    pecl install xdebug && docker-php-ext-enable xdebug && \
    pecl install mongodb && docker-php-ext-enable mongodb && \
    pecl install redis && docker-php-ext-enable redis && \
    yes '' | pecl install imagick && docker-php-ext-enable imagick

RUN COMPOSER_ALLOW_SUPERUSER=1 curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require --prefer-dist "fxp/composer-asset-plugin:*"

RUN mkdir -p /opt/icu/icudt52l/ && \
    curl http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2015e/44/le/metaZones.res > /opt/icu/icudt52l/metaZones.res && \
    curl http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2015e/44/le/timezoneTypes.res > /opt/icu/icudt52l/timezoneTypes.res && \
    curl http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2015e/44/le/windowsZones.res > /opt/icu/icudt52l/windowsZones.res && \
    curl http://source.icu-project.org/repos/icu/data/trunk/tzdata/icunew/2015e/44/le/zoneinfo64.res > /opt/icu/icudt52l/zoneinfo64.res

RUN mkdir -p /var/log/php-fpm

RUN ln -sf /dev/stdout /var/log/php-fpm/access.log
RUN ln -sf /dev/stderr /var/log/php-fpm/error.log

CMD ["php-fpm"]



