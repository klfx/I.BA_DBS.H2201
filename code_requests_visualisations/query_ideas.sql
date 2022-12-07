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

select avg(rating),movieId from ratings group by movieId order by avg(rating) desc;