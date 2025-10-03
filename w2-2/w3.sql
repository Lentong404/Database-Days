SELECT "title" FROM "books" WHERE "publisher_id" = (
    SELECT "id" FROM "publishers" WHERE "publisher" = 'MacLehose Press');

SELECT "rating" FROM "ratings" WHERE "book_id" =(
    SELECT "id" FROM "books" WHERE "title" = 'Standing Heavy');

SELECT ROUND(AVG("rating")) FROM "ratings" WHERE "book_id" =(
     SELECT "id" FROM "books" WHERE "title" = 'Standing Heavy');

SELECT "name" FROM "authors" WHERE "id" = (
    SELECT "author_id" FROM "authored" WHERE "book_id" =(
    SELECT "id" FROM "books" WHERE "title" = 'The Birthday Party')
);

-- IN (Finds a match WITHIN a set of values)
SELECT "title" FROM "books" WHERE "id" IN(
    SELECT "book_id" FROM "authored" WHERE "author_id" = (
    SELECT "id" FROM "authors" WHERE "name" = 'Fernanda Melchor')
);

-- Joining the tables 
-- JOIN by default uses 'inner join' which only joins those with matching data
SELECT * FROM "sea_lions" JOIN "migrations" ON "migrations"."id" = "sea_lions"."id";
-- LEFT JOIN (Joins the table on the 'left' ["sea_lions"] with the table on the 'right' ["migrations"])
SELECT * FROM "sea_lions" LEFT JOIN "migrations" ON "migrations"."id" = "sea_lions"."id";
-- RIGHT JOIN 
SELECT * FROM "sea_lions" 
    RIGHT JOIN "migrations" ON "migrations"."id" = "sea_lions"."id";
-- FULL JOIN
SELECT * FROM "sea_lions" 
    FULL JOIN "migrations" ON "migrations"."id" = "sea_lions"."id";
-- NATURAL JOIN (You dont tell which Column for matching, it just guesses.)
SELECT * FROM "sea_lions" NATURAL JOIN "migrations";

SELECT * FROM "sea_lions" JOIN "migrations" ON "migrations"."id" = "sea_lions"."id" WHERE "migrations"."distance" > 1500;

SELECT 'author' AS "profession", "name" FROM "authors"
UNION
SELECT 'translator' AS "profession", "name" FROM "translators";
