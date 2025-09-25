--PRIMARY KEY ("rider_id", "station_id")

ALTER TABLE "visits" 
RENAME TO "taps";

ALTER TABLE "taps"
ADD COLUMN "type" TEXT;
--For typos 
ALTER TABLE "taps"
RENAME COLUMN "x" TO "y";

ALTER TABLE "tapes"
DROP COLUMN "type"; 


-- Easier to edit schema and then use .read schema.sql

CURRENT_TIMESTAMP 
-- Saves the date time