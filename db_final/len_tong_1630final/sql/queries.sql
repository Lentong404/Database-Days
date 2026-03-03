-- Query the view to return the names and number of applications for all adopters who applied for more than one pet DESC
SELECT "Total_Adoptions"."adopter_id", "adopters"."name" FROM "Total_Adoptions"
JOIN "adopters" ON "Total_Adoptions"."adopter_id" = "adopters"."adopter_id"
ORDER BY "Total_Applications" DESC;


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