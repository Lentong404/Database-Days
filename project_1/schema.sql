CREATE TABLE users(
    "user_id" INTEGER,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    "subscription_type" CHECK("subscription_type" IN('Basic','Standard','Premium')),
    PRIMARY KEY ("user_id")
);

CREATE TABLE games(
    "game_id" INTEGER,
    "title" TEXT NOT NULL,
    "genre" TEXT NOT NULL,
    "release_year" INTEGER NOT NULL,
    "rating" CHECK("rating" IN ('E','T','M')),
    "rental_price" REAL NOT NULL CHECK('rental_price' > 0),
    "purchase_price" REAL NOT NULL CHECK('rental_price' > 0),
    PRIMARY KEY ("game_id")
);

CREATE TABLE library(
    "library_id" INTEGER, 
    "user_id" INTEGER, 
    "game_id" INTEGER, 
    "purchase_type" TEXT NOT NULL CHECK("purchase_type" IN('Purchase','Rental')),
    "rental_date" TEXT CHECK("purchase_type" = 'Purchase' OR ("purchase_type" = 'Rental' AND "rental_date" IS NOT NULL)),
    "launch_date" TEXT,
    "expiry_date" TEXT,
    "status" TEXT NOT NULL CHECK("status" IN('Active','Expired')),
    PRIMARY KEY ("library_id"),
    FOREIGN KEY ("user_id") REFERENCES "users"("user_id"),
    FOREIGN KEY ("game_id") REFERENCES "games"("game_id")
);