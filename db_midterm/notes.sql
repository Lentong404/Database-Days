--import schema 
--.read schema.sql

--DROP TABLE ; 

-- Can't directly import to table, must import to temp table
.import --csv customers.csv temp

INSERT INTO "customers"("name", "email", "country")
SELECT "name", "email", "country" FROM "temp";

--artists
.import --csv artists.csv temp

INSERT INTO "artists"("name", "genre")
SELECT "name", "genre" FROM "temp";

--Concerts
.import --csv concerts.csv temp

INSERT INTO "concerts"("artist_id","title","date","ticket_price")
SELECT "artist_id","title","date","ticket_price" FROM "temp";

--Purchases
.import --csv purchases.csv temp

INSERT INTO "purchases"("customer_id","concert_id","purchase_date")
SELECT "customer_id","concert_id","purchase_date" FROM "temp";

--task 3 data 

--1.Add a new customer and concert 
INSERT INTO "customers" ("name", "email", "country")
VALUES ("Sophia Miller", "sophia@mail.com", "France");

INSERT INTO "concerts" ("artist_id","title","date","ticket_price")
VALUES ("2","House Vibes Live","2025-07-10","14.99");


--2. Delete a concert named Synthwave party
DELETE FROM "concerts" WHERE "title" = 'Synthwave Party';

--3. Change Bob Smith's email to bob.smith@newmail.com

UPDATE "customers"
SET "email" = "bob.smith@newmail.com"
WHERE "name" = 'Bob Smith';

--9. Output the summary including all concerts, total tickets sold per concert and total revenue per concert.
SELECT "concerts"."title", COUNT("purchases"."concert_id") AS "total_tickets_sold",
SUM("concerts"."ticket_price") AS "total_revenue"
FROM "concerts"
JOIN "purchases" ON "concerts"."concert_id" = "purchases"."concert_id"
GROUP BY "concerts"."concert_id";