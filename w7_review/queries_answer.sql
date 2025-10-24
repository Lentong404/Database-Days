--5. Add the new passenger and flight
INSERT INTO "passengers" ("passenger_id","name", "email", "country")
VALUES (6,'Michael Carter','michael.carter@example.com','Canada');
--Flight
INSERT INTO "flights" ("flight_id","airline","origin","destination","departure_time","price")
VALUES (5,'SkyJet Airways','Toronto (YYZ)','Los Angeles (LAX)','2025-06-20 14:30','450.00');

DELETE FROM "flights" 
WHERE "flight_id" = 2;
--7. Update passenger's email address
UPDATE "passengers"
SET "email" = 'emma.brown@newdomain.com'
WHERE "name" = 'Emma Brown';

--1. Find all flights operated by SkyJet Airways
SELECT * FROM "flights" WHERE "airline" = 'SkyJet Airways'; -- Correct

SELECT "flight_id", "origin", "destination", "depature_time","price" FROM "flights"
WHERE "airline" = 'SkyJey Airways';

--2. Find all passengers who purchased tickets for a flight departing from Toronto (YYZ)
SELECT "passenger_id" FROM "tickets" WHERE "flight_id" = 5; -- Need to return the passenger name from passenger using ticket id from tickets

SELECT "passengers"."name", "passengers"."email" FROM "passengers" 
JOIN "tickets" ON "passengers"."passenger_id" = "tickets"."passenger_id"
JOIN "flights" ON "tickets"."flights_id" = "flights"."flight_id"
WHERE "flights"."origins" = 'Toronto (YYZ)';

SELECT "name","email" FROM "passengers"
WHERE "passenger_id" IN (
    SELECT "passenger_id" FROM "tickets"
    WHERE "flight_id" = (SELECT "flight_id" FROM "flights"
    WHERE "origin" = 'Toronto (YYZ)')
);
--3. Count total tickets sold for flights operated by SkyJet Airways
SELECT COUNT(*) FROM "tickets" 
WHERE "flight_id" IN (
    SELECT "flight_id" FROM "flights" WHERE "airline" = 'SkyJet Airways'
    ) 
GROUP BY "flight_id";

SELECT COUNT (*) FROM "tickets" AS "total_tickets_sold" 
WHERE "flight_id" = (
    SELECT "flight_id" FROM "flights"
    WHERE "airline" = 'SkyJet Airways'
);
--4. Find the most popular flight
SELECT "flight_id", COUNT("ticket_id") FROM "tickets" GROUP BY "flight_id"; 
-- Did not order by count, so it doesnt return the top one

SELECT "flight_id", COUNT("ticket_id") FROM "tickets" GROUP BY "flight_id" 
ORDER BY COUNT("ticket_id") DESC LIMIT 1;
--If you think returning the flight_id isn't enough, you need to use JOIN 
SELECT "flights"."flight_id", "flights"."airline" COUNT("tickets"."ticket_id") 
FROM "tickets" 
JOIN "tickets" ON "flights"."flight_id" = "tickets"."flight_id"
GROUP BY "flights"."flight_id" 
ORDER BY COUNT("ticket_id") DESC LIMIT 1;


--5. Find total revenue generated from ticket sales
SELECT SUM("price") FROM "flights" WHERE "flight_id" IN (
    SELECT "flight_id" FROM "tickets"
);
-- use = for 1 to 1 match

SELECT SUM("flights"."price") AS "total_revenue" FROM "flights"
JOIN "tickets" ON "flights"."flight_id" = "tickets"."flight_id" --This line is not needed

SELECT 
"flights"."flight_id",
"flights"."airline",
"flights"."origin",
"flights"."destination",
COUNT("tickets"."ticket_id") AS "total_tickets_sold",
SUM("flights"."price") AS "total_revenue",
SUM("total_revenue")
FROM "flights"
JOIN "tickets" ON "flights"."flight_id" = "tickets"."flight_id"
GROUP BY "flights"."flights_id", "flights"."airline", "flights"."origin", "flights"."destination";