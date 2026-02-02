#!/bin/sh

DB_USER_PW=$(cat /run/secrets/db_user_password)
DB_ROOT_PW=$(cat /run/secrets/db_root_password)

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
	mysql_install_db --user=mysql --ldata=/var/lib/mysql
	sed -i "s/DB_NAME/$DB_NAME/g" /var/mariadb/db_create.sql
	sed -i "s/DB_USER_PW/$DB_USER_PW/g" /var/mariadb/db_create.sql
	sed -i "s/DB_USER_NAME/$DB_USER_NAME/g" /var/mariadb/db_create.sql
	sed -i "s/DB_ROOT_PW/$DB_ROOT_PW/g" /var/mariadb/db_create.sql
fi

exec "$@"
