--List all users who rented a game that expired before they started playing.
SELECT "users"."name" FROM "users"
JOIN "library" ON "library"."user_id" = "users"."user_id"
WHERE "expiry_date" < "launch_date" = 'NULL' AND "status" = 'Expired'