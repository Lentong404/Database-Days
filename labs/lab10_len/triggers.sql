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
BEFORE INSERT ON "Albums"
FOR EACH ROW
BEGIN
    SELECT CASE 
        WHEN NEW."stock" < 0 
        THEN RAISE(ABORT, 'Stock quantity cannot be negative') 
    END;
END;