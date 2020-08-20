FROM php:7.4-fpm-alpine3.11

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- \
	--install-dir=/usr/local/bin --filename=composer

# install gd lib
RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev && \
	docker-php-ext-configure gd --with-freetype --with-jpeg && \
	docker-php-ext-install -j$(nproc) gd && \
	apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

RUN apk add --no-cache $PHPIZE_DEPS openssl-dev git

# install ext mongo
RUN pecl channel-update pecl.php.net && \
	pecl install mongodb-1.7.4 && \
	docker-php-ext-enable mongodb && \
	pecl clear-cache 
	# && \
	# apk del $PHPIZE_DEPS

# install extensions
RUN apk add --no-cache \
	libxml2-dev libzip-dev libxslt-dev gmp-dev postgresql-dev && \
	docker-php-ext-install -j$(nproc) pdo pdo_mysql pdo_pgsql soap zip gmp xsl

RUN apk del $PHPIZE_DEPS