/*
7. Anfragen umsetzen

[X] Verbinden mind. zweier Entitätsmengen (Join)
[X] Verarbeiten von Wertemengen zu einem Wert (Aggregat)
[X] Gruppierung von Aggregaten nach mind. Einer Dimension (SQL: group by)
[X] Datensätze filtern (Selektion), Attribute auswählen (Projektion)
[X] Verschachtelung von Queries und Subqueries (Unterabfragen)
*/

#show users with most tags
select count(tag_id),userId from tags group by userId order by count(tag_id) desc;

#show users with most ratings
select count(rating_id),userId from ratings group by userId order by count(rating_id) desc;

select * from ratings where rating < 2.0;

select * from ratings where userId IN (select distinct userId from ratings where rating < 2.0);

#inspect behaviour of sus user 73406
select r.rating_id,m.title,r.rating,r.rating_date from ratings as r inner join movies as m on m.movieId=r.movieId where r.userId = '73406' order by r.rating_date;

#inspect tag behaviour of sus user 73406
select * from tags where userId = 73406;


#Find Films with most ratings
select count(r.movieId),r.movieId,m.title from ratings as r inner join movies as m on r.movieId=m.movieId group by m.movieId order by count(*) desc;

#get mean ratings (1h runtime!!)
select avg(rating),count(rating),movieId from ratings group by movieId;

#mean ratings but with title(too time expensive)
#create view mean_ratings as select avg(r.rating),count(r.rating),r.movieId,m.title from ratings as r inner join movies as m on r.movieId=m.movieId group by r.movieId;
#select * from mean_ratings;

#Zählen der Genres bei Filmen mit >= 6 Genres (AGGREGAT, GROUP BY, SELEKTION, PROJEKTION)
select m.movieId,m.title,count(mg.genreId) as 'Amount genres' from movies as m inner join movies_genres as mg on m.movieId=mg.movieId group by m.movieId having count(mg.genreId) >= 6;

DELIMITER $$
CREATE PROCEDURE popular_movies.search_by_tags(IN tag varchar(30))
BEGIN
	SET @tag = tag;
    SET @searchstring = concat('%',@tag,'%');
	SELECT t.movieId,m.title,t.tag,count(t.movieId) as 'Amount matching tags' FROM tags as t inner join movies as m on t.movieId=m.movieId where t.tag like @searchstring group by t.movieId order by count(t.movieId) desc;
END$$
DELIMITER ;

DROP PROCEDURE popular_movies.search_by_tags;

CALL popular_movies.search_by_tags('pirate');

#Subqueries

#already optimized
select m.movieId,m.title,m.release_year from movies as m inner join movies_genres as mg on m.movieId=mg.movieId inner join genres as g on mg.genreId=g.genreId where g.genrename = 'Adventure';

select movieId from movies_genres as mg inner join genres as g on mg.genreId=g.genreId where g.genrename = 'Adventure';
#set @selectedgenreid := (select genreId from genres where genrename = 'Adventure');
select * from movies where movieId in (select movieId from movies_genres as mg inner join genres as g on mg.genreId=g.genreId where g.genrename = 'Adventure');

select * from movies as m inner join genomescores as gs on m.movieId=gs.movieId inner join genometags as gt on gs.tagId=gt.tagId where gt.tag like 'sci%';

