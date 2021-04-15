FROM php:7.4-apache

ARG WITH_XDEBUG=true

COPY --from=composer:1 /usr/bin/composer /usr/local/bin/composer

RUN apt-get update && \
    apt-get install -y \
		vim \
    	git \
    	libzip-dev \
    	libxslt-dev \
    	libxml2-dev \
    	libicu-dev \
    	libpng-dev \
        zlib1g-dev \
        libonig-dev \
        libjpeg-dev \
        libfreetype6-dev

RUN docker-php-ext-install mbstring

RUN docker-php-ext-install pdo_mysql

RUN docker-php-ext-install bcmath

RUN docker-php-ext-install zip

RUN docker-php-ext-install sockets

RUN docker-php-ext-install xsl

RUN docker-php-ext-install soap

RUN docker-php-ext-install intl

RUN docker-php-ext-configure gd --with-freetype --with-jpeg

RUN docker-php-ext-install gd

RUN a2enmod rewrite

RUN echo 'memory_limit = 4056M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;

RUN if [ $WITH_XDEBUG = "true" ] ; then \
	pecl install xdebug; \
	echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20190902/xdebug.so" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
	echo "error_reporting=E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
	echo "display_startup_errors=On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
	echo "display_errors=On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
	echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
	echo "xdebug.client_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
	echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
	echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
	echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
	echo "xdebug.discover_client_host=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
	echo "xdebug.idekey=docker" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
fi ;

COPY ./apache/000-default.conf /etc/apache2/sites-available/000-default.conf