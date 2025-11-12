--import schema 
.read schema.sql

.import --csv orders.csv temp

INSERT INTO "Albums"("album_id","title","artist","stock","price")
SELECT "album_id", "title", "artist","stock","price" FROM "temp";

INSERT INTO "Customers"("customer_id","name","email")
SELECT "customer_id","name","email" FROM "temp";

INSERT INTO "Order_Items"("order_item_id","order_id","album_id","quantity")
SELECT "order_item_id","order_id","album_id","quantity" FROM "temp";

INSERT INTO "Orders"("order_id","customer_id","order_date")
SELECT "order_id","customer_id","order_date" FROM "temp";

--Part 1. Trigger should subtract quantity from the matching Albums.stock
CREATE TRIGGER reduce_album_stock
AFTER INSERT ON "Order_Items"
FOR EACH ROW
BEGIN
    UPDATE "Albums"
    SET "stock" = "stock" - NEW."quantity"
    WHERE "album_id" = NEW."album_id";
END;

--Part 1. Create a trigger named prevent_negative_stock that aborts if an insert/update attempts to make Albums.stock < 0.
CREATE TRIGGER prevent_negative_stock
BEFORE INSERT ON "Order_Items"
FOR EACH ROW
BEGIN
    SELECT CASE 
        WHEN NEW."Albums"."stock" < 0 
        THEN RAISE(ABORT, 'Stock quantity cannot be negative') 
    END;
END;


-- Part 2.VIEW

CREATE VIEW "order_summary" AS
SELECT "Order_Items"."order_id","Orders"."order_date","Customers"."name", "Albums"."title", "Order_Items"."quantity",("Albums"."price" * "Order_Items"."quantity")AS line_total FROM "Order_Items"
JOIN "Albums" ON "Albums"."album_id" = "Order_Items"."album_id"
JOIN "Orders" ON "Orders"."order_id" = "Order_Items"."order_id"
JOIN "Customers" ON "Customers"."customer_id" = "Orders"."customer_id";

-- Part 2. Query the order_summary view to see if it returns correct data for a few sample orders.


--Part 3. Indexes

CREATE INDEX album_title_index ON Albums (title);

--Part 4. Transactions 

BEGIN TRANSACTION;
INSERT INTO "Orders"('order_id','customer_id','order_date')
VALUES('1005','101','2025-11-11 20:28');

INSERT INTO "Order_Items"('order_item_id','order_id','album_id','quantity')
VALUES('5006','1005','1','2');

INSERT INTO "Order_Items"('order_item_id','order_id','album_id','quantity')
VALUES('5006','1005','4','1');

INSERT INTO "Order_Items"('order_item_id','order_id','album_id','quantity')
VALUES('5006','1005','2','3');

COMMIT;

-- Buying more than is in stock

BEGIN TRANSACTION;
INSERT INTO "Orders"("order_id","customer_id","order_date")
VALUES("1005","101","2025-11-11 20:28");

INSERT INTO "Order_Items"("order_item_id","order_id","album_id","quantity")
VALUES("5006","1005","1","2");

INSERT INTO "Order_Items"("order_item_id","order_id","album_id","quantity")
VALUES("5006","1005","4","6");

INSERT INTO "Order_Items"("order_item_id","order_id","album_id","quantity")
VALUES("5006","1005","2","3");
ROLLBACK;