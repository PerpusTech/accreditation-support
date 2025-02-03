FROM php:8.3.10-fpm-alpine

# Install dependencies
RUN apt-get update -y && apt-get install -y \
    openssl \
    zip \
    unzip \
    git \
    libpq-dev

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_pgsql

# Install mbstring extension
RUN apt-get install -y libonig-dev && docker-php-ext-install mbstring

# Set working directory
WORKDIR /app

# Copy application files to the container
COPY . /app

# Install PHP dependencies using Composer
RUN composer install

# Expose the port that PHP-FPM will listen on
EXPOSE 9000

# Command to start PHP-FPM
CMD ["php-fpm"]
