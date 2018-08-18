# Configuring this project in a local environment using Docker

For this project, I'm using [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/).
Please check official installation instructions.

Create your docker-compose.yml file:
````
cp -v docker-compose.example.yml docker-compose.yml
````

Start Docker:
````
docker-compose up
````

Creating the databases:
* Access the postgres container
````
docker exec -it geocoding_postgres_db_1 bash
````
* Connect to the postgres
````
psql -U postgres
````
* Create the databases
````
create database geocoding_development;
create database geocoding_test;
````