-- #1
SELECT id, title
FROM movie
WHERE yr = 1962;

-- #2
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- #3
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- #4
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- #5
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- #6
SELECT name
FROM actor JOIN casting ON actor.id=casting.actorid
WHERE movieid = 27;

-- #7
SELECT name
FROM actor JOIN casting ON actor.id=casting.actorid
WHERE movieid = 
	(SELECT id
	FROM movie
	WHERE title = 'Alien');

-- #8
SELECT title
FROM movie JOIN casting ON movie.id=casting.movieid 
JOIN actor ON casting.actorid=actor.id
WHERE actor.name = 'Harrison Ford';

-- #9
SELECT title
FROM movie JOIN casting ON movie.id=casting.movieid 
JOIN actor ON casting.actorid=actor.id
WHERE actor.name = 'Harrison Ford' AND casting.ord != 1;

-- #10
SELECT title, name
FROM movie JOIN casting ON movie.id=casting.movieid 
JOIN actor ON casting.actorid=actor.id
WHERE movie.yr = 1962 AND casting.ord = 1;

-- #11
SELECT yr, COUNT(title) 
FROM movie JOIN casting ON movie.id=casting.movieid 
JOIN actor ON casting.actorid=actor.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

-- #12
SELECT title, name
FROM movie JOIN casting ON (movie.id=casting.movieid AND casting.ord = 1)
JOIN actor ON casting.actorid=actor.id
WHERE movieid IN 
	(SELECT movie.id 
	FROM movie JOIN casting ON movie.id=casting.movieid 
	JOIN actor ON casting.actorid=actor.id
	WHERE name='Julie Andrews');

-- #13
SELECT name
FROM movie JOIN casting ON (movie.id=casting.movieid AND casting.ord = 1) 
JOIN actor ON casting.actorid=actor.id
GROUP BY name
HAVING COUNT(title) >= 15
ORDER BY name;

-- #14
SELECT title, COUNT(casting.actorid) AS actors
FROM movie JOIN casting ON movie.id=casting.movieid 
JOIN actor ON casting.actorid=actor.id
WHERE movie.yr = 1978
GROUP BY title
ORDER BY actors DESC, title;

-- #15
SELECT name 
FROM actor JOIN casting ON actor.id = actorid 
JOIN movie ON movie.id = movieid 
WHERE movie.id IN 
	(SELECT movieid 
	FROM casting 
	WHERE actorid IN (SELECT id FROM actor WHERE name  = 'Art Garfunkel')) AND actor.name != 'Art Garfunkel';

