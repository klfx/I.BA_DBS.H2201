CREATE ROLE 'admin';
GRANT ALL ON popular_movies.* TO 'admin';

CREATE USER 'fabien_morgan'@'%' IDENTIFIED BY '';
CREATE USER 'flavio_kluser'@'%' IDENTIFIED BY '';


GRANT ALL PRIVILEGES ON *.* TO 'fabien_morgan'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'flavio_kluser'@'%' WITH GRANT OPTION;

SET DEFAULT ROLE ALL TO 'fabien_morgan'@'%';
SET DEFAULT ROLE ALL TO 'flavio_kluser'@'%';

FLUSH PRIVILEGES;