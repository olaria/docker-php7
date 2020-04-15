FROM php:7.3-fpm-alpine3.11 as build

RUN apk add --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		libxml2-dev \
		git \
		openssl-dev \
		openssl \
		libzip-dev \
		libxslt-dev \
		gmp gmp-dev \
		libpng \
		libpng-dev libjpeg-turbo-dev libwebp-dev zlib-dev libxpm-dev

RUN docker-php-ext-install pdo_mysql soap zip gmp xsl gd
RUN apk del libpng-dev libjpeg-turbo-dev libwebp-dev zlib-dev libxpm-dev

# install ext mongo
RUN pecl install mongodb-1.6.1
RUN docker-php-ext-enable mongodb

RUN rm -r /tmp/*

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer
