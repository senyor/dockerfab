FROM webdevops/php-nginx-dev:5.6

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-install \
        libmagickwand-dev \
        libsasl2-modules \
        mailutils \
    && \
    { \
      echo "[mail function]"; \
      echo "sendmail_path = \"/usr/sbin/sendmail -t -i\""; \
    } >> /opt/docker/etc/php/php.ini && \
    pecl install imagick && \
    echo 'extension=imagick.so' >> /opt/docker/etc/php/php.webdevops.ini && \
    apt-get remove -y \
        libmagickwand-dev \
    && \
    curl -fsSL https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer --no-progress global require "fxp/composer-asset-plugin:~1.3" && \
    composer --no-progress global require "hirak/prestissimo" && \
    apt-get update -q && \
    apt-install --no-install-recommends \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common \
    && \
    curl -fsSL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get update -q && \
    apt-install --no-install-recommends \
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
    apt-install --no-install-recommends \
        yarn

# Install Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google.list && \
    apt-get update && \
    apt-install --no-install-recommends google-chrome-stable && \
    { echo '#!/bin/bash'; echo '/opt/google/chrome/chrome --no-sandbox "$@"'; } > /usr/bin/chrome && \
    chmod +x /usr/bin/chrome

# Install FireFox
ARG FIREFOX_VERSION=58.0.2
RUN FIREFOX_DOWNLOAD_URL=$(if [ $FIREFOX_VERSION = "nightly" ]; \
       then echo "https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=linux64&lang=en-US"; \
       else echo "https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2"; fi) && \
    apt-get update && \
    apt-install --no-install-recommends firefox-esr gtk+2.0 && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
    apt-get -y purge firefox-esr && \
    wget -q --no-verbose -O /tmp/firefox.tar.bz2 $FIREFOX_DOWNLOAD_URL && \
    rm -rf /opt/firefox && \
    tar -C /opt -xjf /tmp/firefox.tar.bz2 && \
    rm /tmp/firefox.tar.bz2 && \
    mv /opt/firefox /opt/firefox-$FIREFOX_VERSION && \
    ln -fs /opt/firefox-$FIREFOX_VERSION/firefox /usr/bin/firefox

# Install GeckoDriver
ARG GECKODRIVER_VERSION=latest
RUN GK_VERSION=$(if [ ${GECKODRIVER_VERSION:-latest} = "latest" ]; \
      then echo $(wget -qO- "https://api.github.com/repos/mozilla/geckodriver/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([0-9.]+)".*/\1/'); \
      else echo $GECKODRIVER_VERSION; fi) && \
    echo "Using GeckoDriver version: "$GK_VERSION && \
    wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GK_VERSION/geckodriver-v$GK_VERSION-linux64.tar.gz && \
    rm -rf /opt/geckodriver && \
    tar -C /opt -zxf /tmp/geckodriver.tar.gz && \
    rm /tmp/geckodriver.tar.gz && \
    mv /opt/geckodriver /opt/geckodriver-$GK_VERSION && \
    chmod 755 /opt/geckodriver-$GK_VERSION && \
    ln -fs /opt/geckodriver-$GK_VERSION /usr/bin/geckodriver

# Install 'pulseaudio' package to support WebRTC audio streams
RUN apt-get update && apt-get install -y pulseaudio

RUN rm -rf /var/lib/apt/lists/* && \
    docker-image-cleanup

COPY postfix/10-init.sh /opt/docker/bin/service.d/postfix.d/10-init.sh

RUN chmod 777 /opt/docker/bin/service.d/postfix.d/10-init.sh
