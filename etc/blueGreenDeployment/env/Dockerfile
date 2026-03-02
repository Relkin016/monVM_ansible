FROM php:8.2-fpm
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
WORKDIR ${PHP_DIR}
#RUN chown -R www-data:www-data ${PHP_DIR}
EXPOSE ${FPM_PORT}
