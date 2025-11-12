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

-- ROLLBACK in case they try to buy more than they can

BEGIN TRANSACTION;
INSERT INTO "Orders"('order_id','customer_id','order_date')
VALUES('1005','101','2025-11-11 20:28');

INSERT INTO "Order_Items"('order_item_id','order_id','album_id','quantity')
VALUES('5006','1005','1','2');

INSERT INTO 'Order_Items'('order_item_id','order_id','album_id','quantity')
VALUES('5006','1005','4','6');

INSERT INTO 'Order_Items'('order_item_id','order_id','album_id','quantity')
VALUES('5006','1005','2','3');
ROLLBACK;