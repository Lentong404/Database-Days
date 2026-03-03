CREATE TABLE adopters (
    "adopter_id" INTEGER,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    "phone" TEXT,
    "join_date" TEXT DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("adopter_id")
);

CREATE TABLE pets (
    "pet_id" INTEGER,
    "name" TEXT NOT NULL,
    "breed" TEXT CHECK("breed" IN('Corgi','Poodle','Golden Retriever','Shiba Inu','Beagle','Persian Cat','Tabby Cat','Corgi','Poodle','Husky')),
    "age" INTEGER CHECK("age" >= 0),
    "available" INTEGER,
    "adoption_fee" INTEGER CHECK ("adoption_fee" >= 0),
    PRIMARY KEY ("pet_id")
);

CREATE TABLE applications (
    "application_id" INTEGER,
    "status" TEXT CHECK ("status" IN('approved','pending','rejected')),
    "application_date" TEXT DEFAULT CURRENT_TIMESTAMP,
    "adopter_id" INTEGER,
    "pet_id" INTEGER,
    PRIMARY KEY ("application_id"),
    FOREIGN KEY ("adopter_id") REFERENCES "adopters"("adopter_id"),
    FOREIGN KEY ("pet_id") REFERENCES "pets"("pet_id")
);