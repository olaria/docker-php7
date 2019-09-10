FROM php:7.3.9-fpm-alpine3.10

RUN apk add --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		libxml2-dev \
		tzdata \
		git \
		openssl-dev \
		openssl \
		libzip-dev \
		gmp gmp-dev

# define timezone
ENV TZ=America/Bahia
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ > /etc/timezone

RUN docker-php-ext-install pdo_mysql soap zip gmp

# install ext mongo
RUN pecl install mongodb
RUN docker-php-ext-enable mongodb

RUN rm -r /tmp/*

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer
