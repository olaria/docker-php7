FROM php:7.2-fpm-alpine3.7

RUN apk add --no-cache \
		$PHPIZE_DEPS \
		openssl-dev

RUN pecl install mongodb && \
    docker-php-ext-enable mongodb && \
    docker-php-ext-install pdo pdo_mysql zip mbstring soap bcmath

RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer