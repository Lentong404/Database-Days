-- 1.Names and cities of all public schools in Massachusetts
SELECT "name", "city" FROM 'schools' WHERE "type" = "Public School District" AND NOT "type" = "Charter District";
--  2.find the names of districts that are no longer operational.
SELECT "name" FROM "districts" WHERE "name" LIKE '%(non-op)';
--3. how much money, on average, districts spent per-pupil last year. 
SELECT AVG("per_pupil_expenditure") FROM "expenditures";
-- 4. Names and Number of schools from the 10 cities with the most public schools. Greatest to least or Alphabetcal
SELECT "city", COUNT("types") AS "Number of Schools" FROM "schools" LIMIT 10;

SELECT "city", COUNT(*) FROM "schools" WHERE "type" = "Public School" GROUP BY "city" ORDER BY COUNT(*) DESC LIMIT 10;
-- 5. write a SQL query to find cities with 3 or fewer public schools by NAME and #
SELECT "city", COUNT(*) FROM "schools" WHERE "type" = "Public School" GROUP BY "city" HAVING COUNT(*) < 3 ORDER BY COUNT(*) DESC;
-- 6. write a SQL query to find the names of schools (public or charter!) that reported a 100% graduation rate.
SELECT "name" FROM "schools" WHERE "id" IN (
    SELECT "school_id" FROM "graduation_rates" WHERE "graduated" = 100
);
-- 7. names of schools (public or charter!) in the Cambridge school district. district whose name is “Cambridge.” 
SELECT "name" FROM "districts" WHERE "name" LIKE '%Cambridge%';

--8.display the names of all school districts and the number of pupils enrolled in each ASC School name (CHECKED UNTIL HERE)
SELECT "name", "expenditures"."pupils" FROM "districts" JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"  GROUP BY "pupils" ORDER BY "name" ASC;

--9.find the name (or names) of the school district(s) with the single least number of pupils.
SELECT "name" FROM "districts" JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id" WHERE "pupils" = ( SELECT MIN("pupils") FROM "expenditures");

--10 Find the 10 public school districts with the highest per-pupil expenditures
SELECT "name" FROM "districts" JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id" WHERE "districts"."id" IN (SELECT "district_id" FROM "expenditures" ORDER BY 'per_pupil_expenditure' DESC LIMIT 10);


--11. display the names of schools, their per-pupil expenditure, and their graduation rate 
--Sort the schools from greatest per-pupil expenditure to least. If two schools have the same per-pupil expenditure, sort by school name
--districts  PRIMARY KEY("id") // graduation_rates PRIMARY KEY("id"),FOREIGN KEY("school_id") REFERENCES "schools"("id")// expenditures  PRIMARY KEY("id") FOREIGN KEY("district_id") REFERENCES "districts"("id")
-- Grad FK-> PKSchool FK-> PKDistrictsPK <-FK Expenditures
-- Info I need is in Grad and Expenditures 


-- Display Names of school /Expenditure Rate / Graduation Rate 

SELECT "per_pupil_expenditure", "graduated" FROM "districts" 
JOIN "expenditures" ON "expenditures"."id" = "districts"."id"
JOIN "schools" ON "schools"."id" = "districts"."id" 
JOIN "graduation_rates" ON "graduation_rates"."id" = "schools"."id"
LIMIT 10;



--12 districts’ names, along with their per-pupil expenditures and percentage of teachers rated exemplary above-average per-pupil expenditures and an above-average percentage of teachers rated “exemplary”
-- Above Avg % Expenditure Rate / Above Avg% of Teachers rated Exemplary / 
-- WHERE "exemplary" > (SELECT AVG("exemplary") FROM "staff_evaluations")

-- Expenditures <- Districts -> Ratings 
SELECT "exemplary" FROM "staff_evaluations" WHERE "exemplary" > (SELECT AVG("exemplary") FROM "staff_evaluations")

SELECT "per_pupil_expenditure" FROM "expenditures" WHERE "per_pupil_expenditure" > (SELECT AVG("per_pupil_expenditure") FROM "expenditures")


SELECT "districts"."name", "staff_evaluations"."exemplary", "expenditures"."per_pupil_expenditure" FROM "districts" AS "testing table"
JOIN "expenditures" ON "expenditures"."id" = "districts"."id" 
JOIN "staff_evaluations" ON "staff_evaluations"."id" = "districts"."id"
WHERE "staff_evaluations"."exemplary" > (SELECT AVG("exemplary") FROM "staff_evaluations") AND
"per_pupil_expenditure" > (SELECT AVG("per_pupil_expenditure") FROM "expenditures")
GROUP BY "id";