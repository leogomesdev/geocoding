# GEOCODING

This is a project using API to get latitude and longitude for an address.

## Configuring the project

Using postgres,create the databases geolocation and geolocation_test

### Configuring with Docker

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
create database geolocation_development;
create database geolocation_test;
````

### Configuring in a local environment
You can run this application in a local environment using your custom environment configs.

## Using

### Authentication

### Consuming the API

### Contributing