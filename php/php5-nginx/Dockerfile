FROM webdevops/php-nginx:5.6

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -yq \
        libmagickwand-dev \
    && \
    pecl install imagick && \
    echo 'extension=imagick.so' >> /opt/docker/etc/php/php.webdevops.ini && \
    apt-get remove -y \
        libmagickwand-dev \
    && \
    rm -rf /var/lib/apt/lists/* && \
    docker-image-cleanup
