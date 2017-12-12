FROM webdevops/php-nginx:alpine-php5

RUN apk add --update --no-cache \
        autoconf \
        dpkg \
        dpkg-dev \
        file \
        g++ \
        gcc \
        imagemagick-dev \
        libc-dev \
        libtool \
        make \
        pcre-dev \
        php5-dev \
        pkgconf \
        re2c \
    && \
    pecl install imagick && \
    echo 'extension=imagick.so' >> /opt/docker/etc/php/php.webdevops.ini && \
    apk del \
        autoconf \
        dpkg \
        dpkg-dev \
        file \
        g++ \
        gcc \
        imagemagick-dev \
        libc-dev \
        libtool \
        make \
        pcre-dev \
        php5-dev \
        pkgconf \
        re2c \
    && \
    docker-image-cleanup
