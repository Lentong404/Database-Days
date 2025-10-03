CREATE TABLE members (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    -- If you try to add a record with an email that is not unique, it will not make the record 
    "membership_type" TEXT NOT NULL CHECK("membership_type" IN ('Standard','Premium', 'VIP')),
    -- You can write check at the bottom of the table, but best to write in line 
    "join_date" TEXT NOT NULL DEFAULT (DATETIME(CURRENT_TIMESTAMP)),
    PRIMARY KEY ("id")
);

-- Current timestamp uses UTC+8 (Greenich time :eyebrow raise:)
-- Adjust it in the back in or in the create schema 

CREATE TABLE classes(
    "class_id" INTEGER,
    -- "class_id" INTEGER PRIMARY KEY AUTOINCREMENT
    -- Best practice is to define the key at the bottom, auto increment is done automatically through sql lite
    "class_name" TEXT NOT NULL,
    "class_type" TEXT,
    "teacher" TEXT NOT NULL,
    "schedule" TEXT NOT NULL CHECK ("schedule" IN ('morning','afternoon','evening'))
    PRIMARY KEY ("class_id")
);

CREATE TABLE "attendence"(
    "attendence_id" INTEGER,
    "member_id" INTEGER, 
    "class_id" INTEGER,
    FOREIGN KEY ("member_id") REFERENCES "members"("id"),
    FOREIGN KEY ("class_id") REFERENCES "classes"("class_id"),
);

-- Todays lesson: Altering table 

ALTER TABLE "classes"
RENAME COLUMN "teacher" TO "instructor";

-- Challenge: Track how long classes last 
ALTER TABLE "classes"
ADD COLUMN "duration" INTEGER NOT NULL DEFAULT 60;

-- Week 5 - Start
-- A new member signs up for the gym. Her name is Alice Johnson. Her email is alice@email.com. Her membership type is Premium

INSERT INTO "members" ("name", "email", "membership_type")
VALUES (
    'Alice Johnson', 'alice@email.com', 'Premium'
);

SELECT * FROM "members";
-- The time for the join_date is incorrect
-- Default time is in UTC 

-- Another member joins: John Doe, johndoe@email.com, Standard 
INSERT INTO "members" ("name", "email", "membership_type")
VALUES (
    'John Doe', 'johndoe@email.com', 'Standard'
);

INSERT INTO "members" ("name", "email", "membership_type", "join_date")
VALUES (
    'Len Tong', 'len@email.com', 'VIP', DATETIME(CURRENT_TIMESTAMP, '-8 hours')
);

-- Specify the date when inserting a record

-- Convert the time when retrieving data using (SELECT)
SELECT "name", DATETIME("join_date", '-7 hours') AS PDT_time FROM "members"
WHERE "id" = 1;

-- Implement it in schema (just ass '-7 hours' to DATETIME(CURRENT_TIMESTAMP))

-- To update the table, drop the tables that need to be updated and then .read schema.sql

-- Add new data to classes
-- The gym introduces a new class "Spin" with Instructor "Kate Smith"
INSERT INTO "classes" ("class_name", "teacher", "schedule")
VALUES (
    'Spin', 'Kate Smith', 'morning'
);

-- Create a file called "members.csv"
-- Can't directly import to the members, must import to temp table
.import --csv members.csv temp

INSERT INTO "members"("name", "email", "membership_type")
SELECT "name", "email", "membership_type" FROM "temp";
-- Above returns an error :eyebrow raise:
SELECT * FROM "temp"
WHERE "membership_type" NOT IN ('Standard','Premium', 'VIP');

UPDATE "classes"
SET "class_name" = 'Spin 30'
WHERE "class_name" = 'Spin';

--Brackets is used for SELECT because it separates the two SELECT statements
INSERT INTO "attendance" ("member_id", "class_id")
VALUES (
    (SELECT "id" FROM "members" WHERE "name" = 'Alice Johnson'),
    (SELECT "class_id" FROM "classes" WHERE "class_name" = 'Spin 30')
);

SELECT * FROM "attendance";

-- Deleting Record 
DELETE FROM "attendance" WHERE "attendance_id" = 1;