--import schema 
--.read schema.sql

--DROP TABLE ; 

-- Create a file called "users.csv"
-- Can't directly import to the members, must import to temp table
.import --csv users.csv temp

INSERT INTO "users"("name", "email", "subscription_type")
SELECT "name", "email", "subscription_type" FROM "temp";

.import --csv games.csv temp

INSERT INTO "games"("title","genre","release_year","rating","rental_price","purchase_price")
SELECT "title","genre","release_year","rating","rental_price","purchase_price" FROM "temp";

--Populate library
INSERT INTO "library" ("user_id","game_id","purchase_type","rental_date","launch_date","expiry_date","status")
VALUES ('1','10','Purchase','NULL','2022-03-03','NULL','Active');

.import --csv library.csv temp

INSERT INTO "library"("user_id","game_id","purchase_type","rental_date","launch_date","expiry_date","status")
SELECT "user_id","game_id","purchase_type","rental_date","launch_date","expiry_date","status" FROM "temp";