CREATE TABLE books (
    "book_id" INTEGER,
    "title" TEXT NOT NULL,
    "author_id" INTEGER,
    "published_year" INTEGER CHECK("published_year" > 1900 AND "published_year" < 2025),
    -- "published_year" INTEGER CHECK(BETWEEN 1900 AND 2025),
    "price" REAL NOT NULL CHECK("price" > 0),
    PRIMARY KEY ("book_id"),
    FOREIGN KEY ("author_id") REFERENCES "authors"("author_id")
);

CREATE TABLE authors (
    "author_id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "birth_year" INTEGER CHECK("birth_year" <= 2023),
    PRIMARY KEY ("author_id")
);

CREATE TABLE members (
    "member_id" INTEGER,
    "name" TEXT NOT NULL,
    "join_date" TEXT DEFAULT(DATETIME(CURRENT_TIMESTAMP)),
    "membership_status" TEXT NOT NULL CHECK("membership_status" IN ('Active','In-Active')),
    PRIMARY KEY ("member_id")
);

-- Add a new column email (TEXT, Not Null) to the Members table.

ALTER TABLE "members"
ADD COLUMN "emails" TEXT NOT NULL;

-- Add a new constraint to the Books table ensuring that the price is at least 5.
ALTER TABLE "books"
DROP COLUMN "price";

ALTER TABLE "books"
ADD COLUMN "price" REAL NOT NULL CHECK ("price" > 0) DEFAULT 5;

-- use transaction instead of add constraint