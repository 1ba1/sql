/*
  How many stops are in the database.
*/

SELECT COUNT(id) FROM stops;

/*
  Find the id value for the stop 'Craiglockhart'
*/

SELECT id FROM stops
WHERE name = 'Craiglockhart';

/*
  Give the id and the name for the stops on the '4' 'LRT' service.
*/

SELECT id, name FROM stops
JOIN route ON stop = id
WHERE num = 4 AND company = 'LRT';

/*
  Add a HAVING clause to restrict the output to these two routes.
*/

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num HAVING COUNT(*) = 2;

/*
  Change the queroutey so that it shows the services from Craiglockhart
  to London Road.
*/

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = 149;

/*
  Change the queroutey so that the services between 'Craiglockhart'
  and 'London Road' are shown.
*/

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road';

/*
  Give a list of all the services which connect stops 115 and 137
  ('Haymarket' and 'Leith')
*/

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=115 AND b.stop = 137;

/*
  Give a list of the services which connect the stops
  'Craiglockhart' and 'Tollcross'
*/

SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'Tollcross';

/*
  Give a distinct list of the stops which may be reached from 'Craiglockhart'
  by taking one bus, including 'Craiglockhart' itself,
  offered by the LRT company.
  Include the company and bus no. of the relevant services.
*/

SELECT stopa.name, a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopb.name='Craiglockhart';

/*
  Find the routes involving two buses that can go from Craiglockhart to Lochend.
  Show the bus no. and company for the first bus,
  the name of the stop for the transfer,
  and the bus no. and company for the second bus.
*/

SELECT routex.num, routex.company, stopx.name AS change_at, routey.num, routey.company
  FROM route routex JOIN route routey ON (routex.stop = routey.stop)
  JOIN stops stopx ON (stopx.id = routex.stop)
 WHERE routex.num != routey.num
   AND routex.company IN (SELECT DISTINCT routea.company FROM route routea
                       JOIN stops stopa ON (routea.stop = (SELECT id FROM stops stopa WHERE name = 'Craiglockhart'))
                      WHERE routea.num = routex.num)
   AND routey.company IN (SELECT DISTINCT routeb.company FROM route routeb
                       JOIN stops stopb ON (routeb.stop = (SELECT id FROM stops stopb WHERE name = 'Lochend'))
                      WHERE routeb.num = routey.num);
