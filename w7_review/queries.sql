--1. Find all flights operated by SkyJet Airways
SELECT * FROM "flights" WHERE "airline" = 'SkyJet Airways';
--2. Find all passengers who purchased tickets for a flight departing from Toronto (YYZ)
SELECT "passenger_id" FROM "tickets" WHERE "flight_id" = 5;
--3. Count total tickets sold for flights operated by SkyJet Airways
SELECT COUNT(*) FROM "tickets" WHERE "flight_id" = 1 OR "flight_id" = 5 GROUP BY "flight_id";

SELECT COUNT(*) FROM "tickets" WHERE "flight_id" IN (SELECT "flight_id" FROM "flights" WHERE "airline" = 'SkyJet Airways') GROUP BY "flight_id";
--4. Find the most popular flight
SELECT "flight_id", COUNT("ticket_id") FROM "tickets" GROUP BY "flight_id";
--5. Find total revenue generated from ticket sales
SELECT SUM("price") FROM "flights" WHERE "flight_id" IN (SELECT "flight_id" FROM "tickets");