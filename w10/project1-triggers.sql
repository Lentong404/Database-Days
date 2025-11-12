
CREATE TRIGGER set_expiry_after_insert
AFTER INSERT ON "Rentals"
FOR EACH ROW
BEGIN
    UPDATE "Rentals"
    SET "expiry_date" = CASE
        WHEN NEW."start_date" IS NULL
             THEN DATETIME(NEW."rental_date", '+28 days')
        ELSE DATETIME(NEW."start_date", '+48 hours')
    END
    WHERE "rental_id" = NEW."rental_id";
END;

CREATE TRIGGER set_expiry_after_update
AFTER UPDATE ON "Rentals"
FOR EACH ROW
BEGIN
    -- Only update expiry_date if start_date changed
    UPDATE "Rentals"
    SET "expiry_date" = CASE
        WHEN NEW."start_date" IS NULL
             THEN DATETIME(NEW."rental_date", '+28 days')
        ELSE DATETIME(NEW."start_date", '+48 hours')
    END
    WHERE "rental_id" = NEW."rental_id";
    -- Or rental_id = NEW."rental_id"
END;

-- Why CASE=?
-- CASE in SQL is basically a function or expression returning a value.

-- When we write something like:
-- UPDATE "Rentals"
-- SET "expiry_date" = CASE
--     WHEN ...
--     THEN ...
--     ELSE ...
-- END
-- WHERE "rental_id" = NEW."rental_id";
-- The CASE ... END block is an expression that returns a single value.
-- You do need the = to tell SQLite (or any SQL database) to set the column ("expiry_date") to the result of that CASE expression.

-- Alternate Syntax (Using Parentheses)
-- Sometimes you’ll see:
-- SET "expiry_date" = (
--   CASE 
--     WHEN ...
--     THEN ...
--     ELSE ...
--   END
-- )