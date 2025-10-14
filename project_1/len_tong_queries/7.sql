--Display all games released after 2020, sorted by release year (descending).
SELECT * FROM "games" WHERE "release_year" > 2020 ORDER BY "release_year" DESC;