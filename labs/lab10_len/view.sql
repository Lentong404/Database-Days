CREATE VIEW "order_summary" AS
SELECT "Order_Items"."order_id",
"Orders"."order_date",
"Customers"."name", 
"Albums"."title", 
"Order_Items"."quantity",
"Albums"."price" * "Order_Items"."quantity" AS "line_total" 
FROM "Order_Items"
JOIN "Albums" ON "Albums"."album_id" = "Order_Items"."album_id"
JOIN "Orders" ON "Orders"."order_id" = "Order_Items"."order_id"
JOIN "Customers" ON "Customers"."customer_id" = "Orders"."customer_id";