This project provides a complete WordPress hosting stack composed of:
- NGINX (HTTPS reverse proxy)
- WordPress with PHP-FPM
- MariaDB database

On your machine, in order to run this set up, you will need to have installed:
-Docker
-Docker compose
-make



For security reasons you will have to create your own credentials directory 'secrets'.
There is an example_secrets directory in srcs. you can just rename that to 'secrets' and put the passwords you want in
the respective files (the name of the directory HAS to be 'secrets', it HAS to be at the root of the srcs directory, and the names of the files have to be the same one you have in the example).

db_root_password.txt	->the password of your database
db_user_password.txt	->the password of your user database
wp_admin_password.txt	->admin password for wordpress '#'
wp_user_password.txt	->user password for wordpress '$'

--Goes without saying that you should never share these with anybody--


In the same way, you will also have to make a '.env' file based on the 'example_env' you can find int the srcs directory, and customize it as follows: (follow the arrows ->)
	# General
	DOMAIN_NAME=fceragio.42.fr
	CERTS=/etc/ssl


	# Mariadb
->	DB_HOST="database host name"
->	DB_PORT="the port for the database"
->	DB_NAME="name for the database"
->	DB_USER_NAME="user of the databse"


	# Wordpress
->	WP_TITLE="the title you want"

->	WP_USER_NAME="your first user you want '$'"
->	WP_USER_MAIL="and their e-mail"

->	WP_ADMIN_NAME="your admin nick for wordpress '#'"
->	WP_ADMIN_MAIL="and e-mail"

Lastly you'll have to actually add the hostname to your hosts with the command 'make domain'.

You can now start the services with the command make.

To check if everything properly started, you can use the command
'make ps'. It should show the 3 services running (nginx, mariadb, wordpress).

Now you can go to the page 'https://fceragio.42.fr'.
To access the login page you can procede to 'https://fceragio.42.fr/wp-admin' and log in with your admin name'#' and admin password'#', or with your user name'$' and user password'$'

usefull commands:
	make		first start
	make up		start
	make down	stop
