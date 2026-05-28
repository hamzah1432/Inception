#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initial MariaDB installation..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mysqld --user=mysql --skip-grant-tables &
MYSQL_PID=$!

until mysqladmin ping --silent; do
    sleep 1
done

mariadb -u root << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

wait $MYSQL_PID

echo "MariaDB starting normally..."
exec mysqld --user=mysql