-- 1.Names and cities of all public schools in Massachusetts
SELECT "name", "city" FROM 'schools' WHERE "type" = "Public School District" AND NOT "type" = "Charter District";
--  2.find the names of districts that are no longer operational.
SELECT "name" FROM "districts" WHERE "name" LIKE '%(non-op)';
--2. how much money, on average, districts spent per-pupil last year. 
SELECT AVG("per_pupil_expenditure") FROM "expenditures";
--  Names and Number of schools from the 10 cities with the most public schools. Greatest to least or Alphabetcal
SELECT "city", COUNT("types") AS "Number of Schools" FROM "schools" LIMIT 10;

SELECT "city", COUNT(*) FROM "schools" WHERE "type" = "Public School" GROUP BY "city" ORDER BY COUNT(*) DESC LIMIT 10;
-- write a SQL query to find cities with 3 or fewer public schools by NAME and #
SELECT "city", COUNT(*) FROM "schools" WHERE "type" = "Public School" GROUP BY "city" HAVING COUNT(*) < 3 ORDER BY COUNT(*) DESC;
-- write a SQL query to find the names of schools (public or charter!) that reported a 100% graduation rate.
SELECT "name" FROM "schools" WHERE "id" IN (
    SELECT "school_id" FROM "graduation_rates" WHERE "graduated" = 100
);
-- names of schools (public or charter!) in the Cambridge school district. district whose name is “Cambridge.” 
SELECT "name" FROM "districts" WHERE "name" LIKE '%Cambridge%';

--8.display the names of all school districts and the number of pupils enrolled in each ASC School name (CHECKED UNTIL HERE)
SELECT "name", "expenditures"."pupils" FROM "districts" JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"  GROUP BY "pupils" ORDER BY "name" ASC;

--9.find the name (or names) of the school district(s) with the single least number of pupils.
SELECT "name" FROM "districts" JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id" WHERE "pupils" = ( SELECT MIN("pupils") FROM "expenditures");

--10 Find the 10 public school districts with the highest per-pupil expenditures
SELECT "name" FROM "districts" JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id" WHERE "districts"."id" IN (SELECT "district_id" FROM "expenditures" ORDER BY 'per_pupil_expenditure' DESC LIMIT 10);


--11. display the names of schools, their per-pupil expenditure, and their graduation rate greatest per-pupil expenditure to least] [Or by name]
SELECT "name" FROM "school" JOIN "schools" ON "district_id"."id" = "schools"."id" 
--You want the name from the school table, whose id in both tables 

SELECT 'per_pupil_expenditure' FROM "expenditures" ORDER BY "per_pupil_expenditure" DESC LIMIT 10

SELECT "graduated" FROM "graduation_rates" ORDER BY "graduated" DESC LIMIT 10

--districts  PRIMARY KEY("id") // graduation_rates PRIMARY KEY("id"),FOREIGN KEY("school_id") REFERENCES "schools"("id")// expenditures  PRIMARY KEY("id") FOREIGN KEY("district_id") REFERENCES "districts"("id")
-- Grad -> School -> Districts <- Expenditures
-- Info I need is in Grad and Expenditures 


-- Display Names of school /Expenditure Rate / Graduation Rate 

SELECT "per_pupil_expenditure", "graduated" FROM "districts" 
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id" 
JOIN "schools" ON "districts"."id" = "schools"."id" 
JOIN "graduation_rates" ON "schools"."id" = "graduation_rates"."id"
LIMIT 10;

SELECT "per_pupil_expenditure" FROM "expenditures"
UNION 
SELECT "name" FROM "schools"
UNION
SELECT "graduated" FROM "graduation_rates" LIMIT 10;

--12 districts’ names, along with their per-pupil expenditures and percentage of teachers rated exemplary above-average per-pupil expenditures and an above-average percentage of teachers rated “exemplary”
-- Above Avg % Expenditure Rate / Above Avg% of Teachers rated Exemplary / 

-- staff_evaluations -> Districts <- Expenditures

-- WHERE "exemplary" > (SELECT AVG("exemplary") FROM "staff_evaluations")

--Above AVG rate from Staff Eval
SELECT "name", "exemplary" FROM "districts" JOIN "staff_evaluations" ON "districts"."id" = "staff_evaluations"."id" WHERE "districts"."id" IN (
    SELECT "id" FROM "staff_evaluations" WHERE "exemplary" > (
        SELECT AVG("exemplary") FROM "staff_evaluations")
)

UNION
-- Above AVG rate of spending 
SELECT "name", "per_pupil_expenditure" FROM "districts" JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id" WHERE "districts"."id" IN (
    SELECT "district_id" FROM "expenditures" WHERE 'per_pupil_expenditure' > (
        SELECT AVG("per_pupil_expenditure") FROM "expenditures")
);
--

SELECT "id", AVG("exemplary") AS "average rating" FROM "staff_evaluations" WHERE "exemplary" > (
    SELECT AVG("exemplary") FROM "staff_evaluations")

UNION

SELECT "id", AVG("per_pupil_expenditure") AS "average spending" FROM "expenditures" WHERE 'per_pupil_expenditure' > (
        SELECT AVG("per_pupil_expenditure") FROM "expenditures")

GROUP BY "id";

--

SELECT AVG("exemplary") AS "average rating" FROM "staff_evaluations"
JOIN "districts" ON "staff_evaluations"."district_id" = "districts"."id" 
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id" 
GROUP BY "district_id"
HAVING "average rating" > (SELECT AVG("exemplary"));