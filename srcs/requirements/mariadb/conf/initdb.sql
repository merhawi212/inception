
FLUSH PRIVILEGES;
-- database sertup best practices
-- clean everything that comes as a default

DELETE FROM mysql.user WHERE user='';
DELETE FROM mysql.user WHERE User='' or User=' ';
DELETE FROM mysql.user WHERE User='PUBLIC';
DELETE FROM mysql.db WHERE User='PUBLIC';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE db='test';


-- Security best practices
-- remove root remote access.
-- change the root password for the localhost
DELETE FROM mysql.user WHERE user='root' AND host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PWD';



--- Create custom database and user
-- set new password to the newly created user
-- Grant privilate to the new database
CREATE DATABASE IF NOT EXISTS $WP_DB_NAME;
CREATE USER '$WP_DB_USR'@'%' IDENTIFIED BY '$WP_DB_PWD';
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USR'@'%';

FLUSH PRIVILEGES;
