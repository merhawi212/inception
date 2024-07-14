#!/bin/sh

# Check and create /run/mysqld directory if not found
if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

# Check the data store folder and create it if not found
if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Set permissions for /var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql

    # Initialize MariaDB if not already initialized
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null
fi

TMP_SQL_SCRIPT_FILE=tmp.sql
INIT_DB_SQL=/tmp/initdb.sql
# The below command will read the initdb.sql and substiute the required env vars and redirect to the tmp.sql
envsubst < $INIT_DB_SQL > $TMP_SQL_SCRIPT_FILE

# Boot using the SQL commands to initialize the database
mysqld --user=mysql --bootstrap < $TMP_SQL_SCRIPT_FILE

rm -f $TMP_SQL_SCRIPT_FILE


# Allow remote connections by modifying my.cnf and bind with localhost
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

# Start MariaDB server in console mode
mysqld --user=mysql --console
