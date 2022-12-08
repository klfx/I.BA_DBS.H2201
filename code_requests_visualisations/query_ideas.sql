/*
7. Anfragen umsetzen

[X] Verbinden mind. zweier Entitätsmengen (Join)
[] Verarbeiten von Wertemengen zu einem Wert (Aggregat)
[] Gruppierung von Aggregaten nach mind. Einer Dimension (SQL: group by)
[] Datensätze filtern (Selektion), Attribute auswählen (Projektion)
[] Verschachtelung von Queries und Subqueries (Unterabfragen)
*/

#show users with most ratings
select count(tag_id),userId from tags group by userId order by count(tag_id) desc;

select * from ratings where rating < 2.0;

select * from ratings where userId IN (select distinct userId from ratings where rating < 2.0);

#inspect behaviour of sus user 73406 (almost 200k ratings)
select r.rating_id,m.title,r.rating,r.rating_date from ratings as r inner join movies as m on m.movieId=r.movieId where r.userId = '73406' order by r.rating_date;

#Find Films with most ratings
select count(r.movieId),r.movieId,m.title from ratings as r inner join movies as m on r.movieId=m.movieId group by m.movieId order by count(*) desc;