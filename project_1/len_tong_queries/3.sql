--Retrieve all rentals that are still active.

SELECT * FROM "library" WHERE "purchase_type" = 'Rental' AND "status" = 'Active';