Output of this query (LIMIT 2000)

`select avg(rating),count(rating),movieId from ratings group by movieId;`

* Runtime >1h
* Run without LIMIT for extensive list
* Execution Plan attached for optimization