FROM php:7.1-fpm

RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y \
    && apt-get install git zip unzip zlib1g-dev libxml2-dev php-soap autoconf pkg-config libssl-dev -y \
    && pecl channel-update pecl.php.net && pecl install channel://pecl.php.net/geospatial-0.2.0 \
    && pecl install mongodb-1.3.4 \
    && echo "extension=mongodb.so" > $PHP_INI_DIR/conf.d/mongodb.ini

RUN docker-php-ext-install pdo pdo_mysql zip soap mbstring

RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

RUN rm -rf /tmp/pear

USER www-data