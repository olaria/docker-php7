FROM php:7.3-fpm-alpine3.11

RUN apk add --no-cache $PHPIZE_DEPS \
	openssl openssl-dev

# install ext mongo
RUN pecl install mongodb-1.6.1 && \
	docker-php-ext-enable mongodb

# install gd lib
RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev && \
  docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
  docker-php-ext-install -j$(nproc) gd && \
  apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- \
	--install-dir=/usr/local/bin --filename=composer

# install extensions
RUN apk add --no-cache --virtual .build-deps \
	libxml2-dev libzip-dev libxslt-dev gmp-dev postgresql-dev git && \
	docker-php-ext-install -j$(nproc) pdo pdo_mysql pdo_pgsql soap zip gmp xsl
