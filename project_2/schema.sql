CREATE TABLE "Users" (
    "user_id" INTEGER PRIMARY KEY,
    "user_name" TEXT NOT NULL,
    "user_email" TEXT NOT NULL UNIQUE,
    "char_id" INTEGER,
    "last_login" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "friend_list_id" INTEGER,
    PRIMARY KEY ("user_id"),
    FOREIGN KEY ("friend_list_id") REFERENCES "Friend_List"("friend_list_id"),
    FOREIGN KEY ("char_id") REFERENCES "Character"("char_id"),
);

CREATE TABLE "Friend_List" (
    "friend_list_id" INTEGER PRIMARY KEY,
    "friend_user_id" INTEGER,
    "friend_char_id" TEXT,
    PRIMARY KEY ("friend_list_id")
    FOREIGN KEY ("friend_user_id") REFERENCES "Friend_List"("user_id"),
    FOREIGN KEY ("friend_char_name") REFERENCES "Character"("char_id"),
);

CREATE TABLE "Character" (
    "char_id" INTEGER PRIMARY KEY,
    "user_id" INTEGER,
    "char_name" TEXT,
    "char_gender" TEXT CHECK("char_gender" IN('Male','Female', 'Non-Binary')),
    "char_faction" INTEGER,
    "char_class" TEXT CHECK("char_class" IN('Warrior','Rogue', 'Mage')),
    "char_weapon" TEXT,
    "char_gold" INTEGER CHECK ("char_gold" >= 0),
    "char_level" INTEGER,
    PRIMARY KEY ("char_id"),
    FOREIGN KEY ("user_id") REFERENCES "Users"("user_id"),
    FOREIGN KEY ("char_faction") REFERENCES "Factions"("faction_id")
);

CREATE TABLE "Companion" (
    "comp_id " INTEGER PRIMARY KEY,
    "comp_name" INTEGER UNIQUE NOT NULL,
    "comp_faction" TEXT NOT NULL,
    PRIMARY KEY ("comp_id"),
    FOREIGN KEY ("comp_faction") REFERENCES "Factions"("faction_id")
);

CREATE TABLE "Active_Party" (
    "party_id " INTEGER PRIMARY KEY,
    "char_id" INTEGER NOT NULL,
    "member_type" TEXT CHECK("member_type" IN('Companion','Friend')),
    "companion_id" INTEGER,
    "friend_char_id" INTEGER,
    "slot_position" INTEGER CHECK ("slot_position" > 4),
    PRIMARY KEY ("party_id"),
    FOREIGN KEY ("char_id") REFERENCES "Character"("char_id"),
    FOREIGN KEY ("companion_id") REFERENCES "Companion"("comp_id")
);

CREATE TABLE "Factions" (
    "faction_id " INTEGER PRIMARY KEY,
    "faction_name" INTEGER UNIQUE NOT NULL,
    "faction_leader" INTEGER,
    PRIMARY KEY ("faction_id"),
    FOREIGN KEY ("faction_leader") REFERENCES "NPC"("npc_id")
);

CREATE TABLE "NPC" (
    "npc_id " INTEGER PRIMARY KEY,
    "npc_name" INTEGER UNIQUE,
    "faction_id" INTEGER,
    "npc_class" TEXT,
    "npc_weapon" TEXT,
    "npc_gold" INTEGER CHECK ("npc_gold" >= 0),
    PRIMARY KEY ("npc_id"),
    FOREIGN KEY ("faction_id") REFERENCES "Factions"("faction_id")
);

CREATE TABLE "Items" (
    "item_id " INTEGER PRIMARY KEY,
    "item_name" TEXT,
    "item_type" TEXT,
    "sell_cost" INTEGER CHECK ("sell_cost" >= 0),
    "rarity" TEXT,
    PRIMARY KEY ("item_id")
);

CREATE TABLE "NPC_Inventory" (
    "npc_inventory_id " INTEGER PRIMARY KEY,
    "npc_id" INTEGER,
    "item_id" INTEGER,
    "buy_cost" INTEGER CHECK ("buy_cost" >= 0),
    "quantity" INTEGER CHECK ("quantity" >= 0),
    PRIMARY KEY ("npc_inventory_id"),
    FOREIGN KEY ("npc_id") REFERENCES "NPC"("npc_id"),
    FOREIGN KEY ("item_id") REFERENCES "Items"("item_id")
);