--Find all rentals that have expired, along with their rental and expiry dates.
SELECT "title","rental_date","expiry_date" FROM "library"
JOIN "games" ON "library"."game_id" = "games"."game_id"
WHERE "status" = 'Expired' AND WHERE "purchase_type" = 'Rental';