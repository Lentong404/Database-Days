
SELECT (
    (SELECT SUM("rental_price") FROM "games" WHERE "game_id" IN (SELECT "game_id" FROM "library" WHERE "purchase_type" = 'Rental'))
    +
    (SELECT SUM("purchase_price") FROM "games" WHERE "game_id" IN (SELECT "game_id" FROM "library" WHERE "purchase_type" = 'Purchase'))
)
AS "total_sum";


