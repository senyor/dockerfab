FROM webdevops/php-nginx:5.6

RUN export DEBIAN_FRONTEND=noninteractive && \
    docker-service enable postfix && \
    apt-get update && \
    apt-install \
        libmagickwand-dev \
        libsasl2-modules \
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
    rm -rf /var/lib/apt/lists/* && \
    docker-image-cleanup

COPY postfix/10-init.sh /opt/docker/bin/service.d/postfix.d/10-init.sh

RUN chmod 777 /opt/docker/bin/service.d/postfix.d/10-init.sh
