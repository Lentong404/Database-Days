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