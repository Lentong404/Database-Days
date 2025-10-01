--Video 1:
INSERT INTO "stations" ("id", "name", "line")
VALUES (1, 'Waterfront', 'Canada Line');

--SKIP the id 

INSERT INTO "stations" ("name", "line")
VALUES ('Vancouver City Center', 'Canada Line');

-- Unique Constraint in action 

INSERT INTO "stations" ("id", "name", "line")
VALUES ('Waterfront', 'Canada Line');

-- Video 2: 

-- Normal way to add information 
INSERT INTO "stations"("name","line")
VALUES 
('Broadway City Hall', 'Canada Line'),
('Oakridge 41st', 'Canada Line');

SELECT * FROM "stations";

-- Made an Excel file with station name and station line
-- Add the CSV file to the folder 

.import --csv --skip 1 skytrain.csv "stations"

-- There are three columns in the table:stations but only two in the CSV 

.import --csv --skip 1 skytrain.csv temp
-- Import the csv to "temporary" tables 

INSERT INTO "stations" ("name","line")
SELECT "name", "line" FROM "temp";
--Add all "temp" info to "stations"

--Runtime error: UNIQUE constraint failed: stations.name (19)

DROP TABLE "temp";
-- Delete the extra table 

-- Video 3 - Delete data

DELETE FROM "stations"; 
-- Deletes all information in stations. Normally you would use WHERE
DELETE FROM "stations" WHERE "id" > 1; 
-- Deletes from table where id is greater than one (So all information above 1)

.import --csv cards.csv cards

.import --csv taps.csv taps

DELETE FROM "cards"
WHERE "id" = 1;

DELETE FROM "cards"
WHERE "id" = 5;
-- Will result in Error 19: Foreign key constraint failed 
-- If you did not get the above error, make sure the below is on so they will watch for it
PRAGMA foreign_keys = ON;

-- You cannot delete a record that includes a primary key referenced by another tables foreign key 
-- But you can add references to what happens to the FK when the Record with the PK is deleted 

FOREIGN KEY("xxx_id") REFERENCES "table"("id")
ON DELETE  
    NO ACTION --
    SET NULL -- Set the value to be NULL 
    SET DEFAULT, -- Set the value to be a default 
    CASCADE -- When PK is deleted the FK should be deleted 

-- ON DELETE CASCADE 

-- Video 4 Updating Data
SELECT * FROM "stations";
--YVVR Airport is incorrectly spelled -> use update keyword 
UPDATE "tablename"
    SET "column1" = "value1", "column2" = "value2";

-- The above command will update all rows so they end up with the same value
UPDATE "tablename"
    SET "column1" = "value1", "column2" = "value2"
WHERE "id" = 1;

UPDATE "stations" 
    SET "name" = 'YVR-Airport'
WHERE "id" = 54;
