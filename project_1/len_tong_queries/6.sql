--List all games owned by users with a "Premium" subscription.

SELECT "name","title" FROM "games" 
JOIN "library" ON "library"."game_id" = "games"."game_id"
JOIN "users" ON "library"."user_id" = "users"."user_id"
WHERE "subscription_type" = 'Premium' AND WHERE "purchase_type" = 'Purchase';