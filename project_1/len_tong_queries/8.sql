-- Calculate the average price of games in the "Horror" genre.
SELECT AVG("purchase_price") FROM "games" WHERE "genre" = 'Horror';