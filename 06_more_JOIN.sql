/*
  List the films where the yr is 1962 [Show id, title]
*/

SELECT id, title FROM movie
WHERE yr=1962

/*
  Give year of 'Citizen Kane'.
*/

SELECT yr FROM movie
WHERE title = 'Citizen Kane';

/*
  List all of the Star Trek movies, include the id, title and yr
  (all of these movies include the words Star Trek in the title).
  Order results by year.
*/

SELECT id, title, yr FROM movie
WHERE title LIKE 'Star Trek%';

/*
  What id number does the actor 'Glenn Close' have?
*/

SELECT id FROM actor
WHERE name = 'Glenn Close';

/*
  What is the id of the film 'Casablanca'
*/

SELECT id FROM movie
WHERE title = 'Casablanca';

/*
  Obtain the cast list for 'Casablanca'.
*/

SELECT name FROM actor
JOIN casting ON actorid = id
WHERE movieid = 11768;

/*
  Obtain the cast list for the film 'Alien'
*/

SELECT name FROM actor
JOIN casting ON actor.id = casting.actorid
JOIN movie ON movie.id = casting.movieid
WHERE movie.title = 'Alien';

/*
  List the films in which 'Harrison Ford' has appeared
*/

SELECT title FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford';

/*
  List the films where 'Harrison Ford' has appeared - but not in the starring role. 
*/
SELECT title FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford' AND casting.ord != 1;