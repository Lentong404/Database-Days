CREATE TABLE customers(
    "customer_id" INTEGER,
    "name" TEXT NOT NULL,
    "email" TEXT UNIQUE NOT NULL,
    "country" TEXT NOT NULL,
    PRIMARY KEY ("customer_id")
);

CREATE TABLE artists(
    "artist_id" INTEGER,
    "name" UNIQUE NOT NULL,
    "genre" TEXT CHECK("genre" IN ('rock','country','classical','other')),
    PRIMARY KEY ("artist_id")
);

CREATE TABLE concerts(
    "concert_id" INTEGER,
    "artist_id" INTEGER,
    "title" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "ticket_price" REAL NOT NULL CHECK ("ticket_price" > 0),
    PRIMARY KEY ("concert_id"),
    FOREIGN KEY ("artist_id") REFERENCES "artists"("artist_id") ON DELETE CASCADE
);

CREATE TABLE purchases(
    "purchase_id" INTEGER,
    "customer_id" INTEGER,
    "concert_id" INTEGER,
    "purchase_date" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("purchase_id"),
    FOREIGN KEY ("customer_id") REFERENCES "customers"("customer_id"),
    FOREIGN KEY ("concert_id") REFERENCES "concerts"("concert_id")
);