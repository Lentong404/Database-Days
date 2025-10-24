--1.import schema 
.read schema.sql

--2. import passengers to temp
.import --csv passengers.csv temp
INSERT INTO "passengers"("passenger_id","name", "email", "country")
SELECT "passenger_id","name", "email", "country" FROM "temp";

--3. Drop Temp, import flights to temp
DROP TABLE "temp";
.import --csv flights.csv temp
INSERT INTO "flights"("flight_id","airline","origin","destination","departure_time","price")
SELECT "flight_id","airline","origin","destination","departure_time","price" FROM "temp";

--4. Drop Temp, import tickets to temp
.import --csv tickets.csv temp
INSERT INTO "tickets"("ticket_id","passenger_id","flight_id","purchase_date")
SELECT "ticket_id","passenger_id","flight_id","purchase_date" FROM "temp";

--5. Add the new passenger and flight
INSERT INTO "passengers" ("passenger_id","name", "email", "country")
VALUES (6,'Michael Carter','michael.carter@example.com','Canada');
--Insert will automatically create passenger_id if imported from temp table

--Flight
INSERT INTO "flights" ("flight_id","airline","origin","destination","departure_time","price")
VALUES (5,'SkyJet Airways','Toronto (YYZ)','Los Angeles (LAX)','2025-06-20 14:30','450.00');

DELETE FROM "flights" 
WHERE "flight_id" = 2;
-- It didn't delete from tickets =_= 

--Solved: 
PRAGMA "foreign_keys" = ON

--7. Update passenger's email address
UPDATE "passengers"
SET "email" = 'emma.brown@newdomain.com'
WHERE "name" = 'Emma Brown';

-- Ending notes: 
-- Follow the instructions, the table names were Capitalized 
-- In the case of "popular", you can make a comment noting that there could be two 'popular' choices.

