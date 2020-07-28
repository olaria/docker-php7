FROM php:7.4-fpm-alpine3.11

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- \
	--install-dir=/usr/local/bin --filename=composer

# install gd lib
RUN apk add --no-cache libpng-dev && \
  docker-php-ext-install -j$(nproc) gd

RUN apk add --no-cache $PHPIZE_DEPS
RUN apk add --no-cache openssl-dev git

# install ext mongo
RUN pecl channel-update pecl.php.net
RUN pecl install mongodb-1.7.4 
RUN docker-php-ext-enable mongodb
RUN pecl clear-cache
RUN apk del $PHPIZE_DEPS

# install extensions
RUN apk add --no-cache \
	libxml2-dev libzip-dev libxslt-dev gmp-dev && \
	docker-php-ext-install -j$(nproc) soap zip gmp xsl
