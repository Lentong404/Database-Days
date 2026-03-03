--4. Find all concerts by DJ Wave 
SELECT * FROM "concerts" WHERE "artist_id" IN(
    SELECT "artist_id" FROM "artists" WHERE "name" = 'DJ Wave'
);

--5. Find all customers who purchased tickets sold for a concert called "Electro Beats"
SELECT "customers"."name" FROM "customers"
JOIN "purchases" ON "purchases"."customer_id" = "customers"."customer_id"
JOIN "concerts" ON "concerts"."concert_id" = "purchases"."concert_id"
WHERE "concerts"."title" = 'Electro Beats';

--6. Count total tickets sold for a concert by "The Rockers"
SELECT COUNT("purchases"."purchase_id") AS "total_tickets_sold"
FROM "purchases"
JOIN "concerts" ON "concerts"."concert_id" = "purchases"."concert_id"
JOIN "artists" ON "artists"."artist_id" = "concerts"."artist_id"
WHERE "artists"."name" = 'The Rockers';

--7. Find the most popular concert
SELECT "concerts"."title", COUNT("purchases"."purchase_id") AS "total_tickets_sold"
FROM "concerts"
LEFT JOIN "purchases" ON "purchases"."concert_id" = "concerts"."concert_id"
GROUP BY "concerts"."concert_id"
ORDER BY "total_tickets_sold" DESC
LIMIT 1;

--8. Find the total revenue generated from ticket sales.
SELECT COUNT("purchases"."concert_id") AS "total_tickets_sold",
SUM("concerts"."ticket_price") AS "total_revenue"
FROM "purchases"
JOIN "concerts" ON "concerts"."concert_id" = "purchases"."concert_id"
GROUP BY "concerts"."concert_id";

--Forget to turn on Pragma keys so my cascade in my schema for concert deletion upon artist deletion did not work Sorry

--9. Output the summary including all concerts, total tickets sold per concert and total revenue per concert.
SELECT "concerts"."title", COUNT("purchases"."concert_id") AS "total_tickets_sold",
SUM("concerts"."ticket_price") AS "total_revenue"
FROM "concerts"
JOIN "purchases" ON "purchases"."concert_id" = "concerts"."concert_id"
GROUP BY "concerts"."concert_id";