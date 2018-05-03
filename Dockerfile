FROM php:7.2-fpm

RUN apt-get update && apt-get autoremove -y \
    && apt-get install git zip unzip zlib1g-dev -y \
    && apt-get clean -y

RUN docker-php-ext-install pdo pdo_mysql zip mbstring

RUN rm /etc/apt/preferences.d/no-debian-php
RUN apt-get install -y libxml2-dev php-soap
RUN docker-php-ext-install soap

RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

RUN apt-get install -y autoconf pkg-config libssl-dev \
	&& pecl install mongodb \
	&& echo "extension=mongodb.so" > $PHP_INI_DIR/conf.d/mongodb.ini
RUN docker-php-ext-install bcmath