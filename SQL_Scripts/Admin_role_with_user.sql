CREATE ROLE 'admin';
GRANT ALL ON popular_movies.* TO 'admin';

CREATE USER IF NOT EXISTS 'fabien_morgan'@'%' IDENTIFIED BY '';
CREATE USER IF NOT EXISTS 'flavio_kluser'@'%' IDENTIFIED BY '';

GRANT ALL PRIVILEGES ON *.* TO 'fabien_morgan'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'flavio_kluser'@'%' WITH GRANT OPTION;

SET DEFAULT ROLE ALL TO 'fabien_morgan'@'%';
SET DEFAULT ROLE ALL TO 'flavio_kluser'@'%';

SHOW GRANTS FOR 'fabien_morgan'@'%';
SHOW GRANTS FOR 'flavio_kluser'@'%';

FLUSH PRIVILEGES;

/*
DROP USER 'fabien_morgan'@'%';
DROP USER 'flavio_kluser'@'%';
*/