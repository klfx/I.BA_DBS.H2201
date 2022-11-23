#KLF 2022-11-23

#Prerequisites: Find trusted dir to paste files (because secure-file-privileges)
SHOW VARIABLES WHERE `Variable_name` = 'secure_file_priv';

CREATE DATABASE IF NOT EXISTS popular_movies;
USE popular_movies;

CREATE TABLE IF NOT EXISTS movies (
	movieId	MEDIUMINT NOT NULL,
    title VARCHAR(255) NOT NULL,
	#genres VARCHAR(255) NOT NULL,
    release_year SMALLINT NOT NULL,
	PRIMARY KEY (movieId)
);

CREATE TABLE IF NOT EXISTS ratings (
	#additional identifier
    rating_id INT AUTO_INCREMENT,
	userId MEDIUMINT NOT NULL,
    movieId MEDIUMINT NOT NULL,
    rating DECIMAL (2,1) NOT NULL,
    
    #custom name b.c. function name
    rating_date DATETIME NOT NULL,
    
    PRIMARY KEY(rating_id),
    FOREIGN KEY (movieId) REFERENCES movies(movieId)
);

CREATE TABLE IF NOT EXISTS tags (
	tag_id INT AUTO_INCREMENT,
    userId MEDIUMINT NOT NULL,
    movieId MEDIUMINT NOT NULL,
    tag VARCHAR(255) NOT NULL,
    tag_date DATETIME NOT NULL,
    PRIMARY KEY(tag_id),
    FOREIGN KEY (movieId) REFERENCES movies(movieId)
);

CREATE TABLE IF NOT EXISTS links (
	movieId MEDIUMINT NOT NULL,
    imdbId VARCHAR(10) NOT NULL ,
    tmdbId INT DEFAULT NULL,
    PRIMARY KEY(movieId),
    FOREIGN KEY (movieId) REFERENCES movies(movieId)
);

CREATE TABLE IF NOT EXISTS genometags (
	tagId SMALLINT NOT NULL,
    tag VARCHAR(255) NOT NULL,
    PRIMARY KEY(tagId)
);

CREATE TABLE IF NOT EXISTS genomescores (
	movieId MEDIUMINT NOT NULL,
    tagId SMALLINT NOT NULL,
    relevance DECIMAL(7,6) NOT NULL,
    PRIMARY KEY(movieId,tagId),
    FOREIGN KEY(movieId) REFERENCES movies(movieId),
    FOREIGN KEY(tagId) REFERENCES genometags(tagId)
);

CREATE TABLE IF NOT EXISTS genres(
	genreId TINYINT NOT NULL,
    genrename VARCHAR(15) NOT NULL,
	PRIMARY KEY(genreId)
);

CREATE TABLE IF NOT EXISTS movies_genres (
	movieId MEDIUMINT NOT NULL,
    genreId TINYINT NULL,
    /*PRIMARY KEY(movieId, genreId),*/
    /*because of null values, but can be solved.*/
    FOREIGN KEY(movieid) REFERENCES movies(movieId),
	FOREIGN KEY(genreId) REFERENCES genres(genreId)
    );

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\data\\movies.csv'
INTO TABLE movies
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(movieId,@title,@genre)
SET title = @title,
	release_year = ifnull(regexp_substr(@title,'\\d{4}(?!.*\\d)'),-1);

#select regexp_substr('3,3456 Grumpier 2000 Old Men (1995),Comedy|Romance','\\d{4}(?!.*\\d)');

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\data\\ratings.csv'
INTO TABLE ratings
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@u_id,@m_id,@rat,@t1)
SET userId = @u_id,
	movieId = @m_id,
    rating = @rat,
	rating_date = FROM_UNIXTIME(@t1);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\data\\tags.csv'
INTO TABLE tags
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@u_id,@m_id,@tag,@t1)
SET userId = @u_id,
	movieId = @m_id,
    tag = @tag,
	tag_date = FROM_UNIXTIME(IFNULL(@t1,0));
    
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\data\\links.csv'
INTO TABLE links
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
#https://stackoverflow.com/questions/25857468/mysql-load-infile-from-csv-null-last-column
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(movieId,imdbId,@tmdbid)
SET tmdbId = NULLIF(@tmdbid,'');


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\data\\genome-tags.csv'
INTO TABLE genometags
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\data\\genome-scores.csv'
INTO TABLE genomescores
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\data\\genres.csv'
INTO TABLE genres
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\data\\movie_genre.csv'
INTO TABLE movies_genres
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(movieId,@GenreId)
SET genreId = nullif(@GenreId,'');