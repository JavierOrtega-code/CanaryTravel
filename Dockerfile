# Usamos una imagen oficial de PHP con Apache
# 1. Usamos una imagen con PHP y Apache
FROM php:8.2-apache

# 2. Instalamos utilidades del sistema y extensiones de PHP
RUN apt-get update && apt-get install -id -y \
    git \
    unzip \
    libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# 3. Instalamos Composer (la herramienta que crea la carpeta vendor)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 4. Copiamos los archivos de tu proyecto
COPY . /var/www/html/

# 5. Ejecutamos composer para instalar las librerías (Google, Duffel, etc.)
# Esto creará la carpeta /vendor que te falta
RUN composer install --no-interaction --optimize-autoloader

# 6. Permisos y Apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www/html/

EXPOSE 80