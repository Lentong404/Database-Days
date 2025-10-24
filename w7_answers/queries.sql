--1. Find all flights operated by "SkyJet Airways".
SELECT "flight_id", "origin", "destination", "departure_time", "price"
FROM "Flights"
WHERE "airline" = 'SkyJet Airways';

-- 2.Find all passengers who purchased tickets for a flight departing from "Toronto (YYZ)".
SELECT "Passengers"."name", "Passengers"."email"
FROM "Passengers"
JOIN "Tickets" ON "Passengers"."passenger_id" = "Tickets"."passenger_id"
JOIN "Flights" ON "Tickets"."flight_id" = "Flights"."flight_id"
WHERE "Flights"."origin" = 'Toronto (YYZ)';
-----OR------
SELECT "name", "email" FROM "Passengers"
WHERE "passenger_id" IN (
     SELECT "passenger_id" FROM "Tickets"
     WHERE "flight_id" = (
        SELECT "flight_id" FROM "Flights"
        WHERE "origin" = 'Toronto (YYZ)'
     )
);

--3. Count the total number of tickets sold for flights operated by "SkyJet Airways".
SELECT COUNT("Tickets"."ticket_id") AS "total_tickets_sold"
FROM "Tickets"
JOIN "Flights" ON "Tickets"."flight_id" = "Flights"."flight_id"
WHERE "Flights"."airline" = 'SkyJet Airways';
----OR------
SELECT COUNT(*) FROM "Tickets" AS "total_tickets_sold"
WHERE "flight_id" = (
     SELECT "flight_id" FROM "Flights"
     WHERE "airline" = 'SkyJet Airways'
);  

--4. Find the most popular flight (the one with the most ticket purchases).
SELECT "Flights"."flight_id", "Flights"."airline", COUNT("Tickets"."ticket_id") AS "total_tickets_sold"
FROM "Flights"
LEFT JOIN "Tickets" ON "Flights"."flight_id" = "Tickets"."flight_id"
GROUP BY "Flights"."flight_id"
ORDER BY "total_tickets_sold" DESC
LIMIT 1;
----OR (this will only return flight_id)-----
SELECT "flight_id", COUNT("ticket_id") FROM "Tickets"
GROUP BY "flight_id"
ORDER BY COUNT("ticket_id") DESC
LIMIT 1;

--5. Find the total revenue generated from ticket sales. 
SELECT COUNT("Tickets"."ticket_id") AS "total_tickets_sold",
SUM("Flights"."price") AS "total_revenue"
FROM "Flights"
JOIN "Tickets" ON "Flights"."flight_id" = "Tickets"."flight_id"
GROUP BY "Flights"."flight_id", "Flights"."airline", "Flights"."origin", "Flights"."destination";

