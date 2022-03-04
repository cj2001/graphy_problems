-- The following can be run via the psql command line or pgAdmin

-- Confirm the number of airports (should be 3503)
SELECT COUNT(*) FROM airports;

-- Examine the airport table
SELECT * FROM airports LIMIT 10;

-- Examine the countries table
SELECT * FROM countries LIMIT 10;

-- Examine the continents table
SELECT * FROM continents;

-- Examine the routes table
SELECT * FROM routes LIMIT 10;

-- Examine the iroutes table
SELECT * FROM iroutes LIMIT 10;
