/*
  Shows the population for Germany
*/

SELECT population FROM world
WHERE name = 'Germany';

/*
  Shows the name and the population for 'Sweden', 'Norway' and 'Denmark'.
*/

SELECT name, population FROM world
WHERE name IN ('Sweden', 'Norway','Denmark');

/*
  Shows the name and the area between a range
*/

SELECT name, area FROM world
WHERE area BETWEEN 200000 AND 250000;
