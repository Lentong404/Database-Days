-- 1.Names and cities of all public schools in Massachusetts
SELECT "name", "city" FROM 'schools' WHERE "type" = "Public School District" AND NOT "type" = "Charter District";
--  2.find the names of districts that are no longer operational.
SELECT "name" FROM "districts" WHERE "name" LIKE '%(non-op)';
--2. how much money, on average, districts spent per-pupil last year. 
SELECT AVG("per_pupil_expenditure") FROM "expenditures";
--  Names and Number of schools from the 10 cities with the most public schools. Greatest to least or Alphabetcal
SELECT * FROM "schools" LIMIT 10;
SELECT "city", COUNT("types") AS "Number of Schools" FROM "schools";

SELECT "city", COUNT(*) FROM "schools" WHERE "type" = "Public School" GROUP BY "city" ORDER BY COUNT(*) DESC LIMIT 10;
-- write a SQL query to find cities with 3 or fewer public schools by NAME and #
SELECT "city", COUNT(*) FROM "schools" WHERE "type" = "Public School" GROUP BY "city" HAVING COUNT(*) < 3 ORDER BY COUNT(*) DESC;
-- write a SQL query to find the names of schools (public or charter!) that reported a 100% graduation rate.
SELECT "name" FROM "schools" WHERE "id" IN (
    SELECT "school_id" FROM "graduation_rates" WHERE "graduated" = 100
);
-- names of schools (public or charter!) in the Cambridge school district. district whose name is “Cambridge.” (CHECKED UNTIL HERE)
SELECT "name" FROM "districts" WHERE "name" LIKE '%Cambridge%';
--8.display the names of all school districts and the number of pupils enrolled in each ASC School name 
SELECT "name", COUNT("pupils") FROM "districts" JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id" GROUP BY "pupils" ORDER BY "name" ASC;
--9.find the name (or names) of the school district(s) with the single least number of pupils.
SELECT "name" FROM "districts" JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id" WHERE 

SELECT "pupils", "district_id" FROM "expenditures" ORDER BY "pupils" ASC;
--1758

--10 