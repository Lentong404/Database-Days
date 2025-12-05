.import --csv stylewise_clients.csv temp

INSERT INTO "clients"("client_id","name","email","phone")
SELECT "client_id","name","email","phone" FROM "temp";

.import --csv stylewise_appointments.csv temp
INSERT INTO "appointments"("appointment_id","client_id","stylist_id","appointment_date","confirmed","service")
SELECT "appointment_id","client_id","stylist_id","appointment_date","confirmed","service" FROM "temp";

.import --csv stylewise_stylists.csv temp
INSERT INTO "stylists"("stylist_id","name","specialty","available_slots")
SELECT "stylist_id","name","specialty","available_slots" FROM "temp";

-- View to show clients with more than 2 appointments

CREATE VIEW "multi_appointment" AS
SELECT "clients"."name", "clients"."email", "appointments"."appointment_date", "appointments"."service" FROM "clients"
JOIN "appointments" ON "appointments"."client_id" = "clients"."client_id"
GROUP BY "appointments"."client_id"
HAVING COUNT("appointments"."client_id") >= 2
ORDER BY "name";

--ANS
CREATE VIEW "frequent_clients" AS 
SELECT "client_id", COUNT(*) AS "total_appointments"
FROM "appointments"
GROUP BY "client_id"
HAVING "total_appointments" > 1;

--Query the View 
SELECT "frequent_clients"."client_id", "clients"."name"
FROM "frequent_clients"
JOIN "clients"

-- Trigger to automatically reduce the stylist slot by 1 when a new appointment is booked.

CREATE TRIGGER reduce_slot
AFTER INSERT ON "appointments"
FOR EACH ROW
BEGIN
    UPDATE "stylists"
    SET "available_slots" = "available_slots" - NEW."available_slots"
    WHERE "stylist_id" = NEW."stylist_id";
END;

--ANS
CREATE TRIGGER "reduce_slot"
AFTER INSERT ON "appointments"
FOR EACH ROW
BEGIN
    UPDATE "stylists"
    SET "available_slots" = "available_slots" - 1
    WHERE "stylist_id" = NEW."stylist_id";
END;

--Case with available slot is 0 



-- Index on Stylist Speciality
CREATE INDEX stylist_speciality ON stylists (specialty);

-- Transaction Book appointment and deduct stylist availability Roll back otherwise
BEGIN TRANSACTION;
    INSERT INTO "appointments"("appointment_id","client_id","stylist_id","appointment_date","confirmed","service")
    VALUES (8,1,2,2025-12-03,1,'Color');
    UPDATE "stylists"
    SET "available_slots" = "available_slots" - 1
    WHERE "id" = 2;
ROLLBACK;
