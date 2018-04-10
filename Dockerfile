FROM php:7.2-fpm

RUN apt-get update && apt-get upgrade -y \
    && apt-get install git zip unzip zlib1g-dev libxml2-dev autoconf pkg-config libssl-dev -y \
    && apt-get clean -y \
    && pecl channel-update pecl.php.net && pecl install channel://pecl.php.net/geospatial-0.2.0 \
    && pecl install mongodb-1.3.4 \
    && echo "extension=mongodb.so" > $PHP_INI_DIR/conf.d/mongodb.ini

RUN rm /etc/apt/preferences.d/no-debian-php
RUN docker-php-ext-install php-soap mbstring pdo pdo_mysql zip

RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

RUN rm -rf /tmp/pear

USER www-data