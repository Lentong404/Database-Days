SELECT "name", "expenditures"."pupils" FROM "districts" JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"  GROUP BY "pupils" ORDER BY "name" ASC;
