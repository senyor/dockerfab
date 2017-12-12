FROM webdevops/php-nginx-dev:5.6

ENV COMPOSER_ALLOW_SUPERUSER=1

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
    curl -fsSL https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    apt-get update -q && \
    apt-get install -y -q --no-install-recommends \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common \
    && \
    curl -fsSL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get update -q && \
    apt-get install -y -q --no-install-recommends \
      build-essential \
      git \
      vim \
      net-tools \
      procps \
      libssl-dev \
      nodejs \
    && \
    chown -R www-data:www-data /var/www && \
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -q && \
    apt-get install -y -q --no-install-recommends \
        yarn \
    && \
    rm -rf /var/lib/apt/lists/* && \
    docker-image-cleanup
