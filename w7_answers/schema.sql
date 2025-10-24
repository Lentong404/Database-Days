CREATE TABLE "Passengers" (
    "passenger_id" INTEGER,
    "name" TEXT NOT NULL,
    "email" TEXT UNIQUE NOT NULL,
    "country" TEXT NOT NULL,
    PRIMARY KEY ("passenger_id")
);

CREATE TABLE "Flights" (
    "flight_id" INTEGER,
    "airline" TEXT NOT NULL,
    "origin" TEXT NOT NULL,
    "destination" TEXT NOT NULL,
    "departure_time" TEXT NOT NULL,
    "price" REAL NOT NULL CHECK ("price" > 0),
    PRIMARY KEY ("flight_id")
);

CREATE TABLE "Tickets" (
    "ticket_id" INTEGER,
    "passenger_id" INTEGER,
    "flight_id" INTEGER,
    "purchase_date" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("ticket_id"),
    FOREIGN KEY ("passenger_id") REFERENCES "Passengers"("passenger_id"),
    FOREIGN KEY ("flight_id") REFERENCES "Flights"("flight_id") ON DELETE CASCADE
);
