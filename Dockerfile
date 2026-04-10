# Usamos una imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instalamos extensiones necesarias para MySQL (PDO)
RUN docker-php-ext-install pdo pdo_mysql

# Habilitamos el módulo de reescritura de Apache
RUN a2enmod rewrite

# Copiamos los archivos de tu proyecto al servidor
COPY . /var/www/html/

# Ajustamos permisos
RUN chown -R www-data:www-data /var/www/html/

# Exponemos el puerto 80
EXPOSE 80