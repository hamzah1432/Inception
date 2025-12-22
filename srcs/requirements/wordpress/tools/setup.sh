#!/bin/bash
set -e

sleep 10

if [ ! -f /var/www/html/wp-config.php ]; then

    wp core download --allow-root

    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb:3306


    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title=$SITE_TITLE \
        --admin_user=$ADMIN_USER \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL

    wp user create $USER_LOGIN $USER_EMAIL --role=author --user_pass=$USER_PASSWORD --allow-root
fi

mkdir -p /run/php

exec /usr/sbin/php-fpm8.2 -F