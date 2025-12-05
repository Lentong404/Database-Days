--import schema
.read schema.sql

-- DROP TABLE ;

-- Users

.import --csv users.csv temp
INSERT INTO "Users"("user_id","user_name","user_email","char_id","last_login")
SELECT "user_id","user_name","user_email","char_id","last_login" FROM "temp";

-- Character
.import --csv characters.csv temp

INSERT INTO "Character"("char_id","user_id","char_name","char_gender","faction_id","char_class","char_gold","char_level")
SELECT "char_id","user_id","char_name","char_gender","faction_id","char_class","char_gold","char_level" FROM "temp";

-- Factions
.import --csv factions.csv temp

INSERT INTO "Factions"("faction_id","faction_name","faction_leader")
SELECT "faction_id","faction_name","faction_leader" FROM "temp";

--NPCS
.import --csv npcs.csv temp

INSERT INTO "NPC"("npc_id","npc_name","faction_id","npc_class","npc_gold")
SELECT "npc_id","npc_name","faction_id","npc_class","npc_gold" FROM "temp";

--Items
.import --csv items.csv temp

INSERT INTO "Items"("item_id","item_name","item_type","sell_cost","rarity")
SELECT "item_id","item_name","item_type","sell_cost","rarity" FROM "temp";

--NPC Inventory
.import --csv npc_inventory.csv temp

INSERT INTO "NPC_Inventory"("npc_inventory_id","npc_id","item_id","buy_cost","quantity")
SELECT "npc_inventory_id","npc_id","item_id","buy_cost","quantity" FROM "temp";

-- SQL Lite Step 4 - 6

--Add a trigger assigning new players "No Faction" automatically
CREATE TRIGGER assign_faction
AFTER UPDATE ON "Character"
FOR EACH ROW
BEGIN
    UPDATE "faction_id"
    SET "faction_id" = 1;
END;


-- View (Viewing the full inventory sold by the NPC)
CREATE VIEW "NPC_Full_Inventory" AS
SELECT "item_name","item_type","sell_cost","rarity","buy_cost","quantity", "npc_gold" FROM "NPC_Inventory"
JOIN "Items" ON "Items"."item_id" = "NPC_Inventory"."item_id"
JOIN "NPC" ON "NPC"."npc_id" = "NPC_Inventory"."npc_id";

-- Indexes
CREATE INDEX buy_and_sell_quantity ON Character (char_name);

-- Transactions 
BEGIN TRANSACTION;
    UPDATE "NPC_Full_inventory" SET "quantity" = "quantity" - 1
    WHERE "item_name" = "Hyacinthe";
    UPDATE "Character" SET "char_gold" = "char_gold" - 1500
    WHERE "char_id" = 1;
    UPDATE "NPC" SET "npc_gold" = "npc_gold" + 1500
    WHERE "npc_id" = 1;
ROLLBACK;

-- Queries

--1. Find the user with the character with the highest level
SELECT "user_name", "char_name", "char_level" FROM "Users" 
JOIN "Character" ON "Users"."char_id" = "Character"."char_id" ORDER BY "char_level" DESC LIMIT 1;

--2. Find the total amount of money from all players. 
SELECT SUM("char_gold") AS "total_gold" FROM "Character";

--3. Sort all Characters by highest level
SELECT "char_name", "char_level" FROM "Character" ORDER BY "char_level" DESC;

--4. Find all characters that have no faction
SELECT "char_name" FROM "Character" 
JOIN "Factions" ON "Factions"."faction_id" = "Character"."char_faction"
WHERE "faction_id" = (
    SELECT "faction_id" FROM "Factions"
    WHERE "faction_name" = 'No Faction'
);

--5. Find the distribution of classes in characters
SELECT "Character"."char_class", COUNT("char_class") FROM "Character"
GROUP BY "Character"."char_class"
ORDER BY COUNT("char_class") DESC;

--6. Find the faction leader of the character "Shuli"
SELECT "Factions"."faction_leader", "Character"."char_name" FROM "Factions"
JOIN "Character" ON "Factions"."faction_id" = "Character"."char_faction"
WHERE "faction_id" = (
    SELECT "char_faction" FROM "Character"
    WHERE "char_name" = 'Shuli'
)
AND "char_name" = 'Shuli';