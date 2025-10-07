SELECT "districts"."name", "staff_evaluations"."exemplary", "expenditures"."per_pupil_expenditure"
FROM "districts"
JOIN "expenditures" ON "districts"."id" =  "expenditures"."district_id"
JOIN "staff_evaluations" ON "districts"."id" = "staff_evaluations"."district_id"
WHERE "districts"."id" IN(
    SELECT "district_id" FROM "expenditures"
    WHERE "per_pupil_expenditure" > (
        SELECT AVG("expenditures"."per_pupil_expenditure") FROM "expenditures")
        INTERSECT 
        SELECT "districts"."id" FROM "staff_evaluations"
        WHERE "exemplary" > (
            SELECT AVG ("exemplary") FROM "staff_evaluations")
)
ORDER BY "staff_evaluations"."exemplary" DESC, "expenditures"."per_pupil_expenditure" DESC;