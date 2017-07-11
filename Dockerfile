FROM php:7.1-fpm

RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y \
    && apt-get install git zip unzip zlib1g-dev -y

RUN docker-php-ext-install pdo pdo_mysql zip

RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

