INSERT INTO "stations" ("id", "name", "line")
VALUES (1, 'Waterfront', 'Canada Line');

--SKIP the id 

INSERT INTO "stations" ("name", "line")
VALUES ('Vancouver City Center', 'Canada Line');

-- Unique Constraint in action 

INSERT INTO "stations" ("id", "name", "line")
VALUES ('Waterfront', 'Canada Line');