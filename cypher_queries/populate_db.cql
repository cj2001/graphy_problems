// Set node constraints
CREATE CONSTRAINT airports IF NOT EXISTS ON (a:Airport) ASSERT a.iata IS UNIQUE;
CREATE CONSTRAINT cities IF NOT EXISTS ON (c:City) ASSERT c.name IS UNIQUE;
CREATE CONSTRAINT regions IF NOT EXISTS ON (r:Region) ASSERT r.name IS UNIQUE;
CREATE CONSTRAINT countries IF NOT EXISTS ON (c:Country) ASSERT c.code IS UNIQUE;
CREATE CONSTRAINT continents IF NOT EXISTS ON (c:Continent) ASSERT c.code IS UNIQUE;

// Populate nodes
WITH 
    'https://raw.githubusercontent.com/cj2001/graphy_problems/main/data/airport-node-list.csv'
    AS url
LOAD CSV WITH HEADERS FROM url AS row
MERGE (a:Airport {iata: row.iata})
MERGE (ci:City {name: row.city})
MERGE (r:Region {name: row.region})
MERGE (co:Country {code: row.country})
MERGE (con:Continent {code: row.continent})
MERGE (a)-[:IN_CITY]->(ci)
MERGE (a)-[:IN_COUNTRY]->(co)
MERGE (ci)-[:IN_COUNTRY]->(co)
MERGE (r)-[:IN_COUNTRY]->(co)
MERGE (a)-[:IN_REGION]->(r)
MERGE (ci)-[:IN_REGION]->(r)
MERGE (a)-[:ON_CONTINENT]->(con)
MERGE (ci)-[:ON_CONTINENT]->(con)
MERGE (co)-[:ON_CONTINENT]->(con)
MERGE (r)-[:ON_CONTINENT]->(con)
SET a.id = row.id,
    a.icao = row.icao,
    a.city = row.city,
    a.descr = row.descr,
    a.runways = toInteger(row.runways),
    a.longest = toInteger(row.longest),
    a.altitude = toInteger(row.altitude),
    a.lat = toFloat(row.lat),
    a.lon = toFloat(row.lon);

// Populate :HAS_ROUTE relationships
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/cj2001/graphy_problems/main/data/iroutes-edges.csv' AS row
MATCH (source:Airport {iata: row.src})
MATCH (target:Airport {iata: row.dest})
MERGE (source)-[r:HAS_ROUTE]->(target)
ON CREATE SET r.distance = toInteger(row.dist);