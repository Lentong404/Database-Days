--Automatically updating stock when an order is placed
CREATE TRIGGER reduce_stock_after_order
AFTER INSERT ON "Order_Items"
FOR EACH ROW
BEGIN
    UPDATE "Products"
    SET "stock_quantity" = "stock_quantity" - NEW."quantity"
    WHERE "product_id" = NEW."product_id";
END;
-- Fires after inserting a row in Order_Items.
-- Subtracts the ordered quantity from Products.stock_quantity.
-- Ensures inventory is automatically updated.

-- 2. Preventing purchases if stock is too low
CREATE TRIGGER prevent_out_of_stock_orders
BEFORE INSERT ON "Order_Items"
FOR EACH ROW
BEGIN
    SELECT CASE 
        WHEN (SELECT "stock_quantity" FROM "Products" WHERE "product_id" = NEW."product_id") < NEW."quantity"
        THEN RAISE(ABORT, 'Not enough stock available')
    END;
END;
-- Stops an order if the stock is too low.
-- Fires before inserting an order item.
-- If the requested quantity exceeds available stock, it blocks the transaction.
-- Prevents overselling.


-- 3. Calculating subtotal before inserting an order item
CREATE TRIGGER calculate_subtotal
BEFORE INSERT ON "Order_Items"
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN NEW."subtotal" IS NULL OR NEW."subtotal" <= 0 THEN
        SET NEW."subtotal" = (SELECT "price" FROM "Products" WHERE "product_id" = NEW."product_id") * NEW."quantity";
    END;
END;

-- Before inserting an order item, it calculates subtotal = price × quantity automatically.
-- Ensures subtotal is always correct.

-- 4. Logging deleted orders for record-keeping

-- Step 1: Create the Order Archive Table
CREATE TABLE "Deleted_Orders" (
    "order_id" INTEGER,
    "customer_id" INTEGER,
    "order_date" TEXT,
    "deleted_at" TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Step 2: Create the Deletion Trigger
CREATE TRIGGER log_deleted_orders
AFTER DELETE ON "Orders"
FOR EACH ROW
BEGIN
    INSERT INTO "Deleted_Orders" ("order_id", "customer_id", "order_date")
    VALUES (OLD."order_id", OLD."customer_id", OLD."order_date");
END;
-- When an order is deleted, it copies the record into Deleted_Orders.
-- Keeps historical data for auditing purposes.
