--List all users who rented a game that expired before they started playing.
SELECT "users"."name" FROM "users"
JOIN "library" ON "library"."user_id" = "users"."user_id"
WHERE "library"."expiry_date" > DATETIME("library"."rental_date", '+30 days');

SELECT "users"."name" FROM "users"
JOIN "library" ON "library"."user_id" = "users"."user_id"
WHERE "launch_date" = 'NULL' AND "status" = 'Expired'