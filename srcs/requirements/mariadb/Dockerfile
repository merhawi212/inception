FROM alpine:3.19
#Update & upgrade existing packages,
#install MariaDB and MariaDB client without cache to keep the image clean and small
RUN	apk update && \
		apk upgrade && \
		apk add --no-cache mariadb  mariadb-client gettext 

# two directories - first one for storing Dbs, tables and other files, 
# and second one for storing runtime files, PID, Socket

RUN mkdir -p /var/lib/mysql /run/mysqld

# security best practice - Principle of Least Privilege
# changing the ownership to one user
RUN  chown -R mysql:mysql /var/lib/mysql /run/mysqld

#intialize db, by default it will create db called mysql
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db

# copy the script to the docker image
COPY ./tools/mariadb_entrypoint.sh /tmp/mariadb_entrypoint.sh
COPY ./conf/initdb.sql /tmp/initdb.sql

LABEL maintainer="Merhawi, mkiflema" \
      version="1.0.0"
#run the script
ENTRYPOINT ["sh", "/tmp/mariadb_entrypoint.sh"]
