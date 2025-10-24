CREATE TABLE passengers (
    "passenger_id" INTEGER, 
    "name" TEXT, 
    "email" TEXT UNIQUE NOT NULL, 
    "country" TEXT NOT NULL,
    PRIMARY KEY ("passenger_id")
);

CREATE TABLE tickets (
    "ticket_id" INTEGER, 
    "passenger_id" INTEGER, 
    "flight_id" INTEGER, 
    "purchase_date" TEXT NOT NULL (DATETIME(CURRENT_TIMESTAMP, '-8 hours')),
    PRIMARY KEY ("ticket_id")
    FOREIGN KEY ("passenger_id") REFERENCES "passengers"("passenger_id")
    FOREIGN KEY ("flight_id") REFERENCES "flights"("flight_id")
    ON DELETE CASCADE
);

CREATE TABLE flights(
    "flight_id" INTEGER,
    "airline" TEXT NOT NULL,
    "origin" TEXT,
    "destination" TEXT,
    "departure_time" TEXT NOT NULL,
    "price" REAL NOT NULL CHECK('price' > 0),
    PRIMARY KEY ("flight_id")
);