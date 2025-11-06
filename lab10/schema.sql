-- Albums Table
CREATE TABLE "Albums" (
    "album_id" INTEGER PRIMARY KEY,
    "title" TEXT NOT NULL,
    "artist" TEXT NOT NULL,
    "stock" INTEGER NOT NULL CHECK ("stock" >= 0),
    "price" REAL NOT NULL CHECK ("price" > 0)
);

-- Customers Table
CREATE TABLE "Customers" (
    "customer_id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT UNIQUE NOT NULL
);

-- Orders Table
CREATE TABLE "Orders" (
    "order_id" INTEGER PRIMARY KEY,
    "customer_id" INTEGER NOT NULL,
    "order_date" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("customer_id") REFERENCES "Customers"("customer_id")
);

-- Order_Items Table
CREATE TABLE "Order_Items" (
    "order_item_id" INTEGER PRIMARY KEY,
    "order_id" INTEGER NOT NULL,
    "album_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL CHECK ("quantity" > 0),
    FOREIGN KEY ("order_id") REFERENCES "Orders"("order_id"),
    FOREIGN KEY ("album_id") REFERENCES "Albums"("album_id")
);
