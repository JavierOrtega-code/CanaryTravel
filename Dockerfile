# 1. Usamos una imagen con PHP y Apache
FROM php:8.2-apache

# 2. Instalamos utilidades del sistema y extensiones de PHP
# Corregido: eliminada la 'i' del comando install
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# 3. Instalamos Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 4. Copiamos los archivos de tu proyecto
COPY . /var/www/html/

# 5. Ejecutamos composer install
RUN composer install --no-interaction --optimize-autoloader

# 6. Permisos y Apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www/html/

EXPOSE 80