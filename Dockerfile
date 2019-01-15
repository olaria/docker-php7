FROM php:7.3-fpm-alpine3.8

RUN apk add --no-cache \
		--virtual .phpize_deps \
		$PHPIZE_DEPS \
		libxml2-dev \
        libressl-dev \
        libzip-dev

#Define timezone
ENV TZ=America/Bahia
RUN apk add --no-cache tzdata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ > /etc/timezone

RUN pecl install mongodb \
    && docker-php-ext-enable mongodb \
	&& docker-php-ext-install pdo_mysql zip soap

RUN apk del .phpize_deps

RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer