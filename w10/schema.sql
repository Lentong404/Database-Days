-- Table: Products
CREATE TABLE "Products" (
    "product_id" INTEGER,
    "name" TEXT NOT NULL,
    "price" REAL NOT NULL CHECK("price" > 0),
    "stock_quantity" INTEGER NOT NULL CHECK("stock_quantity" >= 0),
    PRIMARY KEY ("product_id")
);

-- Table: Customers
CREATE TABLE "Customers" (
    "customer_id" INTEGER,
    "name" TEXT NOT NULL,
    "email" TEXT UNIQUE NOT NULL,
    PRIMARY KEY ("customer_id")
)

-- Table: Orders
CREATE TABLE "Orders" (
    "order_id" INTEGER,
    "customer_id" INTEGER NOT NULL,
    "order_date" TEXT DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("order_id"),
    FOREIGN KEY ("customer_id") REFERENCES "Customers"("customer_id") ON DELETE CASCADE
);

-- Table: Order_Items (Many-to-Many between Orders and Products)
CREATE TABLE "Order_Items" (
    "order_item_id" INTEGER,
    "order_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL CHECK("quantity" > 0),
    "subtotal" REAL NOT NULL CHECK("subtotal" > 0),
    PRIMARY KEY ("order_item_id"),
    FOREIGN KEY ("order_id") REFERENCES "Orders"("order_id") ON DELETE CASCADE,
    FOREIGN KEY ("product_id") REFERENCES "Products"("product_id") ON DELETE CASCADE
);
