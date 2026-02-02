#!/bin/sh

DB_USER_PW=$(cat /run/secrets/db_user_password)
WP_USER_PW=$(cat /run/secrets/wp_user_password)
WP_ADMIN_PW=$(cat /run/secrets/wp_admin_password)

echo "Waiting for MariaDB to be ready..."
until mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER_NAME" -p"$DB_USER_PW" -e "SELECT 1;" >/dev/null 2>&1; do
  sleep 2
done
echo "MariaDB is up!"

if [ -f "/var/www/wordpress/wp-config.php" ]; then
	echo "Wordpress already exist"
else
	wp core download --allow-root
	echo "wp core downloaded"
	wp core config --dbname="$DB_NAME" --dbuser="$DB_USER_NAME" --dbpass="$DB_USER_PW" --dbhost="$DB_HOST:$DB_PORT" --dbprefix='wp_' --allow-root
	echo "WP db configured"
	wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_NAME" --admin_password="$WP_ADMIN_PW" --admin_email="$WP_ADMIN_MAIL" --allow-root
	echo "wp installed"
	echo "wp user create $WP_USER_NAME $WP_USER_MAIL --role='subscriber' --user_pass="$WP_USER_PW" --allow-root"
	wp user create $WP_USER_NAME $WP_USER_MAIL --role='subscriber' --user_pass="$WP_USER_PW" --allow-root
	echo "wp user added"
fi
exec "$@"
