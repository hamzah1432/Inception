#!/bin/bash
set -e

while ! mariadb-admin ping -h"mariadb" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Configuring WordPress..."
    
    wp core download --allow-root --path=/var/www/html --force

    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb:3306 --path=/var/www/html

    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title=$SITE_TITLE \
        --admin_user=$ADMIN_USER \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL --path=/var/www/html

    wp user create $USER_LOGIN $USER_EMAIL --role=author --user_pass=$USER_PASSWORD --allow-root --path=/var/www/html
fi

mkdir -p /run/php
echo "WordPress is starting..."
exec /usr/sbin/php-fpm8.2 -F