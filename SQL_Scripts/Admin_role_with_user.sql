CREATE ROLE 'admin';
GRANT ALL ON popular_movies.* TO 'admin';

CREATE USER 'fabien_morgan'@'%' IDENTIFIED BY '';
CREATE USER 'flavio_kluser'@'%' IDENTIFIED BY '';


GRANT admin TO 'fabien_morgan'@'%';
GRANT admin TO 'flavio_kluser'@'%';

SET DEFAULT ROLE ALL TO 'fabien_morgan'@'%';
SET DEFAULT ROLE ALL TO 'flavio_kluser'@'%';

