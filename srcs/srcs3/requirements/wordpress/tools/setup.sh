#!/bin/bash
set -e

while ! mariadb-admin ping -h"mariadb" --silent; do
    echo "WordPress is waiting for MariaDB..."
    sleep 3
done

cd /var/www/html
chown -R www-data:www-data /var/www/html

# 3. التأكد من التثبيت الآلي
if ! wp core is-installed --allow-root 2>/dev/null; then
    echo "WordPress not installed. Starting installation..."

    wp core download --allow-root --force

    # إنشاء ملف الإعدادات
    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb --path=/var/www/html --force

    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="$SITE_TITLE" \
        --admin_user=$ADMIN_USER \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL --skip-email

    wp user create --allow-root \
        $USER_LOGIN $USER_EMAIL \
        --role=author \
        --user_pass=$USER_PASSWORD
    
    echo "WordPress installation and users setup completed successfully!"
else
    echo "WordPress is already installed and configured."
fi

mkdir -p /run/php
echo "WordPress is starting on port 9000..."
exec /usr/sbin/php-fpm8.2 -F