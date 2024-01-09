# Used for prod build.
FROM php:8.1-fpm as php

RUN apt-get update -y


ENV COMPOSER_HOME /var/www/.composer/

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer
COPY ./docker/auth.json $COMPOSER_HOME

ARG APP_ID=1000

# Install dependencies.
RUN apt-get update && apt-get install -y unzip libpq-dev libcurl4-gnutls-dev nginx libonig-dev cron default-mysql-client git gnupg gzip libbz2-dev libjpeg-dev libfreetype6-dev libicu-dev libjpeg62-turbo-dev libmcrypt-dev libonig-dev libpng-dev libsodium-dev libssh2-1-dev libxslt1-dev libzip-dev lsof mailutils msmtp nodejs procps vim zip libmagickwand-dev

# Removes dependencies clear cache.
RUN rm -rf /var/lib/apt/lists/*

# Install dependencies.
RUN pecl install redis \
    ssh2-1.3.1 \
    xdebug \
    imagick \
    && docker-php-ext-enable \
    redis \
    ssh2 \
    xdebug \
    imagick

# Enable GD configuration to fix Magento installation imagecreatefromjpeg object function
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp

# Install PHP extensions.
RUN docker-php-ext-install mysqli pdo pdo_mysql bcmath curl opcache mbstring bz2 calendar exif gd gettext intl pcntl soap sockets sodium
RUN docker-php-ext-install sysvmsg sysvsem sysvshm xsl zip

#RUN docker-php-ext-enable imagick

# Copy composer executable.
COPY --from=composer:2.3.5 /usr/bin/composer /usr/bin/composer

# Copy custom configuration files.
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini
COPY ./docker/php/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf
#COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/entrypoint.sh /usr/local/bin/entrypoint.sh
#COPY ./bin/download-magento.sh /usr/local/bin/download-magento.sh
#COPY ./docker/auth.json /usr/bin/composer/auth.json

RUN mkdir -p /var/www/src
#COPY ./docker/index.php /var/www/src

#RUN chmod +x /usr/local/bin/download-magento.sh

COPY ./bin/download-magento /usr/local/bin/download-magento
RUN chmod +x /usr/local/bin/download-magento

COPY ./bin/install-magento /usr/local/bin/install-magento
RUN chmod +x /usr/local/bin/install-magento

# Set working directory to /var/www.
#WORKDIR /var/www/src

# Adjust user permission & group
RUN usermod --uid "$APP_ID" www-data
RUN groupmod --gid "$APP_ID" www-data

# Copy files from current folder to container current folder (set in workdir).
#COPY --chown=www-data:www-data . .

RUN chown -R www-data:www-data /var/www/src

# Set correct permission.
#RUN chmod -R 777 /var/www/public/var
#RUN chmod -R 777 /var/www/public/generated
#RUN chmod -R 777 /var/www/public/pub

#VOLUME . /var/www/src
WORKDIR /var/www/src

# Run the entrypoint file.
#ENTRYPOINT [ "docker/entrypoint.sh" ]
ENTRYPOINT ["/bin/bash", "entrypoint.sh"]

#ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
#CMD ["php-fpm", "-D"]
