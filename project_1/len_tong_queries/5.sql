--Display the names of users who own the most games.
SELECT "name", COUNT("game_id") FROM "users"
JOIN "library" ON "library"."user_id" = "users"."user_id"
WHERE "purchase_type" = 'Purchase' GROUP BY "users"."user_id" ORDER BY "library"."game_id" DESC;