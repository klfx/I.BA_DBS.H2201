CREATE INDEX tag_name_i ON tags(tag);
#DROP INDEX tag_name_i ON tags;

CREATE INDEX userId_i ON ratings(userId);
CREATE INDEX movieId_i ON ratings(movieId);
CREATE INDEX rating_i ON ratings(rating);
CREATE INDEX rating_date_i ON ratings(rating_date);

CREATE INDEX title_i ON movies(title);
CREATE INDEX release_year_i ON movies(release_year);

CREATE INDEX imdbId_i ON links(imdbId);
CREATE INDEX tmdbId_i ON links(tmdbId);

CREATE INDEX genrename_i ON genres(genrename);

CREATE INDEX tag_i ON genometags(tag);

CREATE INDEX tagId_relevance_i ON genomescores(tagId,relevance);