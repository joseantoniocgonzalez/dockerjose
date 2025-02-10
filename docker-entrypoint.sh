#!/bin/bash
set -e  # Detiene el script si hay algún error

echo "⏳ Esperando a que MariaDB esté listo..."
while ! mysqladmin ping -h"$DB_HOST" --silent; do
    sleep 2
done

echo "✅ MariaDB está en línea."

# Verificar si la base de datos ya está inicializada
if [ ! -f /var/www/html/db_initialized ]; then
    echo "📂 Inicializando la base de datos..."
    mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" < /var/www/html/biblioteca.sql || echo "⚠️ La base de datos ya fue inicializada"
    touch /var/www/html/db_initialized
fi

echo "🚀 Iniciando Apache en el puerto 8081..."
# Ejecutar Apache en primer plano
apache2ctl -D FOREGROUND
