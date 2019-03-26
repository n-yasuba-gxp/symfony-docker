FROM php:7.3.3-apache

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt-get update && apt-get install -y git libzip-dev unzip \
    && docker-php-ext-install zip \
    && a2enmod rewrite headers

COPY ./my-project /var/www/html/my-project
WORKDIR /var/www/html/my-project

ENV APACHE_DOCUMENT_ROOT /var/www/html/my-project/public
COPY ./config/vhost.conf /etc/apache2/sites-available/000-default.conf

RUN composer install