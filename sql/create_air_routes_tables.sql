DROP DATABASE IF EXISTS air_routes;
CREATE DATABASE air_routes;

\c air_routes;

CREATE TABLE airports (
    ID INT PRIMARY KEY,
    IATA VARCHAR,
    ICAO VARCHAR,
    CITY VARCHAR,
    DESCR VARCHAR,
    REGION VARCHAR,
    RUNWAYS INT,
    LONGEST INT,
    ALTITUDE INT,
    COUNTRY VARCHAR,
    CONTINENT VARCHAR,
    LAT FLOAT,
    LON FLOAT
);

CREATE TABLE continents (
    CODE VARCHAR,
    DESCR VARCHAR
);

CREATE TABLE countries (
    CODE VARCHAR,
    DESCR VARCHAR
);

CREATE TABLE routes
    (SRC       INTEGER     NOT NULL,
     DEST      INTEGER     NOT NULL,
     DIST      INTEGER     NOT NULL,
     PRIMARY KEY (SRC,DEST));

-- From IATA to IATA routes table
CREATE TABLE iroutes
    (SRC       CHAR(3)     NOT NULL,
     DEST      CHAR(3)     NOT NULL,
     DIST      INTEGER     NOT NULL,
     PRIMARY KEY (SRC,DEST));

