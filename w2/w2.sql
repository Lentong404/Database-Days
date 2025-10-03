SELECT "title" FROM "longlist" WHERE "translator" IS NULL;
SELECT "title" FROM "longlist" WHERE "translator" IS NOT NULL; 
SELECT "title" FROM "longlist" WHERE "title" LIKE '%my%';

SELECT "title" FROM "longlist" WHERE "title" LIKE 'The%';
SELECT "title" FROM "longlist" WHERE "title" LIKE 'The P__e%';

SELECT "title", "year" FROM "longlist" WHERE "year" BETWEEN 2019 AND 2021;
SELECT "title", "rating" FROM "longlist" WHERE "rating" > 4.0 AND "votes" > 1000;

SELECT "title", "rating" FROM "longlist"ORDER BY "rating" DESC LIMIT 20;
SELECT "title", "rating", "votes" FROM "longlist" ORDER BY

SELECT "title", "rating" FROM "longlist" WHERE "votes" > 10000 ORDER BY "rating" DESC LIMIT 20;

SELECT ROUND( AVG("rating")), 2 FROM "longlist";

SELECT ROUND( AVG("rating"),2) AS "Average Rating" FROM "longlist";

SELECT MAX("rating") FROM "longlist";
SELECT MIN("rating") FROM "longlist";

SELECT SUM("rating") FROM "longlist";

SELECT COUNT("publisher") FROM "longlist";
SELECT COUNT( DISTINCT "publisher") FROM "longlist";

SELECT MAX("votes") FROM "longlist"; 
SELECT COUNT ("translator") FROM "longlist";