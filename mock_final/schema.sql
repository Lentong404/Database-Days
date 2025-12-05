CREATE TABLE clients (
    "client_id" INTEGER,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    "phone" TEXT,
    PRIMARY KEY ("client_id")
);

CREATE TABLE stylists (
    "stylist_id" INTEGER,
    "name" TEXT NOT NULL,
    "specialty" TEXT NOT NULL, --CHECK speciality
    "available_slots" INTEGER CHECK("available_slots" <= 8),
    PRIMARY KEY ("stylist_id")
);

CREATE TABLE appointments (
    "appointment_id" INTEGER,
    "client_id" INTEGER,    
    "stylist_id" INTEGER,
    "appointment_date" TEXT NOT NULL, -- Get rid of Not Null add DEFAULT CURRENT_DATE
    "confirmed" INTEGER, -- BOOLEAN 1 or 0
    "service" TEXT NOT NULL,
    PRIMARY KEY ("appointment_id"),
    FOREIGN KEY ("client_id") REFERENCES "clients"("client_id"),
    FOREIGN KEY ("stylist_id") REFERENCES "stylists"("stylist_id")
);