--import schema 
--.read schema.sql

--DROP TABLE ; 

-- Create a file called "users.csv"
-- Can't directly import to the members, must import to temp table
.import --csv users.csv temp

INSERT INTO "users"("name", "email", "subscription_type")
SELECT "name", "email", "subscription_type" FROM "temp";

.import --csv games.csv temp

INSERT INTO "games"("title","genre","release_year","rating","rental_price","purchase_price")
SELECT "title","genre","release_year","rating","rental_price","purchase_price" FROM "temp";

--Populate library
INSERT INTO "library" ("user_id","game_id","purchase_type","rental_date","launch_date","expiry_date","status")
VALUES ('1','10','Purchase','NULL','2022-03-03','NULL','Active');

.import --csv library.csv temp

INSERT INTO "library"("user_id","game_id","purchase_type","rental_date","launch_date","expiry_date","status")
SELECT "user_id","game_id","purchase_type","rental_date","launch_date","expiry_date","status" FROM "temp";

UPDATE "table_name"
SET "column_name" = "new_value"
WHERE "condition"

-- SUM of each WITH UNION
-- SELECT SUM(
--     CASE "purchase_type"
--     WHEN 'Rental'
--         THEN "price_rent"
--     WHEN 'Purchase' 
--         THEN "price_buy"
-- END)
-- AS "Total revenue" 
-- FROM "games"
-- JOIN "library" ON "games"."id" = "library"."game_id";

--Calculate the total revenue generated from purchases and rentals.
SELECT 
    SUM("games"."rental_price") + SUM("games"."purchase_price") AS total_sum
FROM "games"
WHERE "games"."game_id" IN (SELECT "game_id" FROM "library" WHERE "purchase_type" = 'Purchase' OR "purchase_type" = 'Rental');

-- 
SELECT (
    (SELECT SUM("rental_price") FROM "games"
    WHERE "game_id" IN ( SELECT "game_id" FROM "library" WHERE "purchase_type" = 'Rental' ))
    +
    (SELECT SUM("purchase_price") FROM "games"
    WHERE "game_id" IN ( SELECT "game_id" FROM "library" WHERE "purchase_type" = 'Purchase' ))
)
AS "Total Revenue";
