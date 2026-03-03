.read schema.sql

--import csvs 
--Adopters
.import --csv adopters.csv temp
INSERT INTO "adopters"("adopter_id","name","email","phone","join_date")
SELECT "adopter_id","name","email","phone","join_date" FROM "temp";

--Pets
.import --csv pets.csv temp
INSERT INTO "pets"("pet_id","name","breed","age","available","adoption_fee")
SELECT "pet_id","name","breed","age","available","adoption_fee" FROM "temp";

--applications
.import --csv applications.csv temp
INSERT INTO "applications"("application_id","adopter_id","pet_id","status","application_date")
SELECT "application_id","adopter_id","pet_id","status","application_date" FROM "temp";

-- View showing adopter's total applications and count of unique pets applied
CREATE VIEW "Total_Adoptions" AS
SELECT "adopter_id", COUNT(*) AS "Total_Applications"
FROM "applications"
GROUP BY "adopter_id";

-- Query the view to return the names and number of applications for all adopters who applied for more than one pet DESC
SELECT "Total_Adoptions"."adopter_id", "adopters"."name" FROM "Total_Adoptions"
JOIN "adopters" ON "Total_Adoptions"."adopter_id" = "adopters"."adopter_id"
ORDER BY "Total_Applications" DESC;

-- Create a Trigger - Prevents adopter from creating more than two pending applications
CREATE TRIGGER "max_applications"
BEFORE INSERT ON "applications"
FOR EACH ROW 
BEGIN
    SELECT CASE 
        WHEN (SELECT "status" FROM "applications" WHERE "application_id" = NEW."product_id") >= 2
        AND SELECT "status" FROM "applications" WHERE "status" = 'Pending'
        THEN RAISE(ABORT, 'You already have 2 pending applications')
    END;
END;

--Create an index
CREATE INDEX find_breed ON pets (breed);

--Transaction
BEGIN TRANSACTION;
SELECT CASE 
         WHEN "available" > 0 THEN 
            'Available'
         ELSE 
            'ADOPTED'
     END AS "Been_Adopted"
FROM "pets"
WHERE "pet_id" = 7;
INSERT INTO "applications"("application_id","adopter_id","pet_id","status","application_date")
VALUES(19,1,'pending','2025-12-08');
UPDATE "pets"
SET "available" = 0
WHERE "pet_id" = 7;
COMMIT;


