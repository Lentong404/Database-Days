--Calculate the total revenue generated from purchases and rentals.
SELECT 
    SUM("games"."rental_price") + SUM("games"."purchase_price") AS total_sum
FROM "games"
WHERE "games"."game_id" IN (SELECT "game_id" FROM "library" WHERE "purchase_type" = 'Purchase' OR "purchase_type" = 'Rental');

-- SUM of each WITH UNION

