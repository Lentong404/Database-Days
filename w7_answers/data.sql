--import
.import --csv passengers.csv temp
INSERT INTO "Passengers" ("passenger_id", "name", "email", "country")
SELECT "passenger_id", "name", "email", "country" FROM "temp";
DROP TABLE "temp";

--insert a new passenger
INSERT INTO "Passengers" ("name", "email", "country")
VALUES ('Michael Carter', 'michael.carter@example.com', 'Canada');

INSERT INTO "Flights" ("airline", "origin", "destination", "departure_time", "price")
VALUES ('SkyJet Airways', 'Toronto (YYZ)', 'Los Angeles (LAX)', '2025-06-20 14:30', 450.00);

--delee a flight
DELETE FROM "Flights" WHERE "flight_id" = 2;
-- Flight ID 2 is deleted, and because of ON DELETE CASCADE, all tickets for this flight are also removed

-- update a passwernger's email
UPDATE "Passengers"
SET "email" = 'emma.brown@newdomain.com'
WHERE "name" = 'Emma Brown';

