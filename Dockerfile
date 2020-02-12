FROM php:7.4-fpm-alpine3.11

RUN apk add --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		libxml2-dev \
		git \
		openssl-dev \
		openssl \
		libzip-dev \
		libxslt-dev \
		gmp gmp-dev

RUN docker-php-ext-install pdo_mysql soap zip gmp xsl

# install ext mongo
RUN pecl install mongodb-1.6.1
RUN docker-php-ext-enable mongodb

RUN rm -r /tmp/*

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer
