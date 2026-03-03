CREATE VIEW "Total_Adoptions" AS
SELECT "adopter_id", COUNT(*) AS "Total_Applications"
FROM "applications"
GROUP BY "adopter_id";