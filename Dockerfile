# Usar una imagen oficial de PHP con Apache
FROM php:8.0-apache

# Instalar extensiones necesarias y el cliente de MySQL
RUN apt-get update && apt-get install -y \
    nano \
    default-mysql-client \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql \
    && a2enmod rewrite

# Configurar Apache para permitir .htaccess
RUN sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Copiar los archivos del proyecto a /var/www/html
COPY . /var/www/html/

# Establecer permisos
RUN chown -R www-data:www-data /var/www/html

# Copiar el script de entrada
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Exponer el puerto 8081
EXPOSE 8081

# Definir el script de entrada
ENTRYPOINT ["bash", "/usr/local/bin/docker-entrypoint.sh"]
