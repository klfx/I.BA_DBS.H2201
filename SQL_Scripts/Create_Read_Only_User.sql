CREATE ROLE 'visualizer';
GRANT SELECT ON popular_movies.* TO 'visualizer';

CREATE USER 'darth_vader'@'%' IDENTIFIED BY 'wY6ZgH3ib*pd2mRpfbeQ-UER3W8_76';

GRANT visualizer TO 'darth_vader'@'%';

SET DEFAULT ROLE ALL TO 'darth_vader'@'%';

SHOW GRANTS FOR 'darth_vader'@'%';