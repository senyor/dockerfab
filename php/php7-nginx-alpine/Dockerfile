FROM senyor/php7-alpine:latest
MAINTAINER senyor <andrei.kuziakov@gmail.com>

# Environment variables
ENV GETTEXT_VER="0.19.8.1"

# Configure essential and utility packages
RUN apk --update --no-cache add wget tar make gcc g++ zlib-dev pcre-dev fcgi-dev jpeg-dev libmcrypt-dev bzip2-dev curl-dev libpng-dev libxslt-dev postgresql-dev perl-dev file acl-dev libedit-dev \
    nginx pcre zlib supervisor sed re2c m4 ca-certificates py-pip bash vim \
    libressl libressl-dev

RUN mkdir -p /run/nginx/ && \
    rm -f /etc/nginx/nginx.conf && \
    mkdir -p /etc/nginx/conf.d && \
    mkdir -p /etc/nginx/ssl/ && \
    mkdir -p /var/www/html/ && \
    pip install --upgrade pip && \
    pip install supervisor-stdout

# Copy manifest folder
COPY ./manifest/ /

# Set permissions
RUN chmod 755 /entrypoint.sh && \
    chmod ugo+w /run/nginx/ && \
    chmod 775 /var && \
    chmod -R 775 /var/www/ && \
    chown -R nginx:nginx /var/www/

# Setup Volume
VOLUME ["/var/www/html"]
VOLUME ["/etc/nginx/ssl"]
VOLUME ["/var/log/nginx"]

# Expose Ports
EXPOSE 443 80

CMD ["/bin/bash", "/entrypoint.sh"]
