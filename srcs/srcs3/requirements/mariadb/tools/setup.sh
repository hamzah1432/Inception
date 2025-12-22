#!/bin/bash
set -e

# 1. التأكد من وجود مجلد التشغيل (ضروري في Debian)
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# 2. التحقق مما إذا كانت قاعدة البيانات منشأة مسبقاً
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initial MariaDB installation..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# 3. تشغيل الخدمة مؤقتاً للإعداد
mysqld_safe --skip-grant-tables &
sleep 5

# 4. تنفيذ أوامر الإعداد
# ملاحظة: استخدمنا || true ليتجاوز الأخطاء إذا كان المستخدم موجوداً مسبقاً
mariadb -u root << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# 5. إغلاق الخدمة المؤقتة بشكل آمن
# بما أننا غيرنا الباسورد، نحتاج لاستخدامه في الإغلاق
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

# 6. تشغيل MariaDB بشكل دائم (كعملية أساسية للحاوية)
echo "MariaDB starting normally..."
exec mysqld_safe