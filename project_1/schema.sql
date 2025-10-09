CREATE TABLE users{
    "user_id" INTEGER,
    "name" TEXT, NOT NULL,
    "email" TEXT, NOT NULL UNIQUE,
    "subscription_type" CHECK("type" IN('Basic', 'Standard', 'Premium')),
    PRIMARY KEY ("user_id")
}


CREATE TABLE games{
    "game_id" INTEGER,
    "title" TEXT NOT NULL,
    "genre" TEXT NOT NULL,
    "release_year" INTEGER NOT NULL
    "rating" CHECK("rating" IN ('E','T','M'))
    "rental_price" REAL NOT NULL CHECK('rental_price' > 0),
    "purchase_price" REAL NOT NULL CHECK('rental_price' > 0),
    PRIMARY KEY ("game_id")
}

CREATE TABLE rentals {
    "library_id", 
    "user_id", 
    "game_id", 
    "purchase_type" TEXT NOT NULL CHECK("purchase_type" IN('Purchase','Rental')),
    --only required if the purchase_type is "Rental"
    "rental_date" TEXT,
    -- the date/time the user started playing the game (NULL if not started)
    "launch_date" TEXT DATETIME(CURRENT_TIMESTAMP) DEFAULT NULL,
    -- manually enter as 30 days after rental_date if rented*
    -- What does expiry_date contain if rental_date IS Null 
    "expiry_date" TEXT DEFAULT DATETIME("rental_date", '+30 days'),
    "status" TEXT NOT NULL CHECK("status" IN("Active", "Expired")),
    PRIMARY KEY ("library_id"),
    FOREIGN KEY ("user_id") REFERENCES "users"("user_id"),
    FOREIGN KEY ("game_id") REFERENCES "games"("game_id"),
    -- Table level constraint to check multiple columns 
    CHECK("purchase_type" = 'Purchase' OR ("purchase_type" = 'Rental' AND "rental_date" IS NOT NULL))
}
