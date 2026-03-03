-- Create a Trigger - Prevents adopter from creating more than two pending applications
CREATE TRIGGER "max_applications"
BEFORE INSERT ON "applications"
FOR EACH ROW 
BEGIN
    SELECT 
        CASE 
            WHEN (SELECT "status" FROM "applications" WHERE "application_id" = NEW."application_id") >= 2
        THEN RAISE(ABORT, 'You already have 2 pending applications')
    END;
END;