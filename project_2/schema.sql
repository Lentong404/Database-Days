CREATE TABLE Users (
    "user_id" INTEGER,
    "user_name" TEXT NOT NULL,
    "user_email" TEXT NOT NULL UNIQUE,
    "char_id" INTEGER,
    "last_login" DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("user_id"),
    FOREIGN KEY ("char_id") REFERENCES "Character"("char_id")
);

CREATE TABLE Character (
    "char_id" INTEGER,
    "user_id" INTEGER,
    "char_name" TEXT NOT NULL,
    "char_gender" TEXT CHECK("char_gender" IN('Male','Female', 'Non-Binary')),
    "faction_id" INTEGER,
    "char_class" TEXT CHECK("char_class" IN('Warrior','Rogue', 'Mage')),
    "char_gold" INTEGER CHECK ("char_gold" >= 0),
    "char_level" INTEGER,
    PRIMARY KEY ("char_id"),
    FOREIGN KEY ("user_id") REFERENCES "Users"("user_id"),
    FOREIGN KEY ("faction_id") REFERENCES "Factions"("faction_id")
);

CREATE TABLE Factions (
    "faction_id" INTEGER,
    "faction_name" INTEGER UNIQUE NOT NULL,
    "faction_leader" INTEGER,
    PRIMARY KEY ("faction_id"),
    FOREIGN KEY ("faction_leader") REFERENCES "NPC"("npc_id")
);

CREATE TABLE NPC (
    "npc_id" INTEGER,
    "npc_name" INTEGER UNIQUE NOT NULL,
    "faction_id" INTEGER,
    "npc_class" TEXT,
    "npc_weapon" TEXT,
    "npc_gold" INTEGER CHECK ("npc_gold" >= 0),
    PRIMARY KEY ("npc_id"),
    FOREIGN KEY ("faction_id") REFERENCES "Factions"("faction_id")
);

CREATE TABLE Items (
    "item_id" INTEGER,
    "item_name" TEXT,
    "item_type" TEXT CHECK ("item_type" IN ('Consumable','Weapon')),
    "sell_cost" INTEGER CHECK ("sell_cost" >= 0),
    "rarity" TEXT CHECK ("rarity" IN ('Common','Rare','Epic','Legendary')),
    PRIMARY KEY ("item_id")
);

CREATE TABLE NPC_Inventory (
    "npc_inventory_id" INTEGER,
    "npc_id" INTEGER,
    "item_id" INTEGER,
    "buy_cost" INTEGER CHECK ("buy_cost" >= 0),
    "quantity" INTEGER CHECK ("quantity" >= 0),
    PRIMARY KEY ("npc_inventory_id"),
    FOREIGN KEY ("npc_id") REFERENCES "NPC"("npc_id"),
    FOREIGN KEY ("item_id") REFERENCES "Items"("item_id")
);