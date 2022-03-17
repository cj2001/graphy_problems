# Graph Databases versus SQL for Data Science: Identifying ‘Graph-y’ Problems in Your Data
### Written by: Dr. Clair J. Sullivan, Data Science Advocate, Neo4j
#### email: clair.sullivan@neo4j.com
#### Twitter: @CJLovesData1
#### Last updated: March 17, 2022

## Introduction

A frequent question from data scientists is “why would I want to use a graph database when I can do all of what I need to do in SQL?” In some cases an RDBMS is a fine solution. However, there are many times that your data is a graph, even though it might not be immediately recognizable as such. This course walks through how to identify whether a problem is actually a graph and the benefits of analyzing that way rather than traditional using traditional SQL.

In this course we will be working with a data set of routes between airports.  It is based off of the graph data that can be found in [here](https://github.com/krlawrence/graph). 

## Required tools and packages

- Official `neo4j` Python driver (`pip install neo4j`)
- Traditional Python data science packages (`numpy`, `pandas`)
- A notebook environment (Jupyter, Google Colab, VS Code Notebooks, etc.)
- A SQL environment (see comment on Docker below)
- [Neo4j Sandbox](https://sandbox.neo4j.com/)

## Recommended tools

- [Docker](https://www.docker.com/) (optional)
  - We will specifically be using [docker-compose](https://docs.docker.com/compose/install/)
  - The Docker container provided in this repo contains the PostgreSQL database setup for this course.  The `docker-compose.yml` file contains 3 containers.  [Portainer](https://www.portainer.io/) will be used to help us manage and interface with the other two, which are the Postgres database and [pgAdmin 4](https://www.pgadmin.org).
  - The use of Docker is recommended so that we can all be running the same SQL database system while not interfering with any databases on your local machine.  However, if you prefer to not use Docker and use your own Postgres install, you can simply use the database population queries in `./sql`.

## Basic container instructions

In this course we will be building and running the container from the command line.  To bring the container up, run the following command:

```
docker-compose build && docker-compose up
```

Once you are done with the container, you can bring it down by hitting `CTRL+C` and then:

```
docker-compose down
```

### Accessing the various containers

We will be using Portainer to monitor and interface with our containers.  To get into Portainer, use your browser to navigate to [http://localhost:9443](http://localhost:9443).  Note that this is NOT an `https` connection, so you will need to navigate to address through the `Advanced` button.

There are then two ways that we can reach the Postgres database:

#### 1. Using the command line

Via Portainer, open the console for the `pg_container` container.  From there, you can get into Postgres via the following command at the command line:

```
psql -h localhost -U postgres
```

#### 2. Using pgAdmin

Using Portainer, open port 80 of `pgadmin4_container`.  You will need to provide the login and password set in the `docker-compose.yml` file (`admin@admin.com` and `letmein`).  Then you will need to establish a server connection to the database.  This will be done with the IP address of `pg_container` and the login and password for the database set in the `docker-compose.yml` file (`postgres` and `letmein`).  