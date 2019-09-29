FROM php:7.2-cli

LABEL php.version="7.2"
LABEL maintainer="x1unix"
LABEL description="Docker image with minimalistic PHP development environment"

ENV HTTP_PORT 8080
ENV HTTP_ROOT /var/www/html
ENV HTTP_DIR ""
ENV COMPOSER_REQUIRE ""

ADD docker-entrypoint.sh /root
VOLUME ["$HTTP_ROOT"]

# Install PHP extensions
RUN apt update && \
    apt install -y unzip zip zlib* && \
    docker-php-ext-install -j$(nproc) zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV PATH "$PATH:$HOME/bin:$HOME/.config/composer/vendor/bin"

EXPOSE $HTTP_PORT
WORKDIR $HTTP_ROOT
ENTRYPOINT /root/docker-entrypoint.sh
