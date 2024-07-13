#!/bin/sh

# wait for mysql
# while ! mariadb -h$MYSQL_DB_HOST -u$WP_DB_USR -p$WP_DB_PWD $WP_DB_NAME >/dev/null; do
#     sleep 3
# done



# if [ ! -f "/var/www/html/index.html" ]; then

#     # static website
#     # mv /tmp/index.html /var/www/html/index.html

# fi
# Check PHP version (optional)
php81 -v
# Infinite loop to keep the container running

# while true; do
#     sleep 10
# done

WP_CONFIG_FILE=wp-config.php

if [ ! -f $WP_CONFIG_FILE ]; then

	# https://make.wordpress.org/cli/handbook/how-to/how-to-install
	 # Download core files if they are not already present
    if [ ! -f wp-settings.php ]; then
        wp core download --allow-root
    else
        echo "WordPress files already present"
    fi

    # Generate wp-config.php with database credentials
    wp config create \
			--dbname=$WP_DB_NAME \
			--dbuser=$WP_DB_USR \
			--dbpass=$WP_DB_PWD \
			--dbhost=$MYSQL_HOST \
			--dbcharset="utf8" \
			--allow-root
	if [ $? -ne 0 ]; then
		echo "Error: Unable to create wp-config.php file!!!!"
		return 1
	fi
	echo "wp-config.php file created successfully"

    # Install WordPress if not already installed
    if ! $(wp core is-installed --allow-root); then
        wp core install \
            --url=$DOMAIN_NAME \
            --title=$WP_TITLE \
            --admin_user=$WP_ADMIN_USR \
            --admin_password=$WP_ADMIN_PWD \
            --admin_email=$WP_ADMIN_EMAIL \
            --skip-email \
            --allow-root

        if [ $? -ne 0 ]; then
            echo "Error: Unable to install WordPress!!!!"
            exit 1
        fi

        echo "WordPress installed successfully"
    else
        echo "WordPress is already installed"
    fi

	# create user
    wp user create $WP_USR $WP_EMAIL \
		--role=author \
		--user_pass=$WP_PWD \
		--allow-root

    wp theme install inspiro --activate --allow-root

    wp plugin update --all --allow-root

else
    echo "wp-config.php file already exists"
fi

chmod -R 755 /var/www/html/wordpress

echo "Wordpress started on :9000"
php-fpm81 -F