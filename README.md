# GEOCODING

This is a project using API to get latitude and longitude for an address.

## Configuring the project

- Using postgres, create the databases geocoding and geocoding_test.
- Create your database configs by copying and editing the file bellow:
    ````
    cp -v config/database.example.yml config/database.yml
    ````
- Run project migrations
    ````
    rake db:migrate
    ````

### Configuring with Docker

If you wanna to use [Docker](https://www.docker.com/) for a local executation, please check [docs/docker_instructions.md](docs/docker_instructions.md)


### Configuring in a local environment
You can run this application in a local environment using your custom environment configs.

## Running tests

````
rails test
````

## Design

### Endpoints
This app has to endpoints
* _api/v1/**users**_: A POST API to create a new user and receive his token

* _api/v1/**geocoding**_: A GET API to look for informations about one address


###  Important components
This application uses some GEMS, and the not-common GEMS are:

* [Geocoder](https://github.com/alexreisner/geocoder) is used to search for information about one address
* [Rack CORS Middleware](https://github.com/cyu/rack-cors) is used to configure the CORS (Cross-Origin Resource Sharing) and allow external access to the API
* [Rack::Attack](https://github.com/kickstarter/rack-attack) is used to limit 5 access by second for each IP, that prevents from Distributed Denial-of-Service Attack (DDoS Attack)


### Organization of the code
To separate the business rules from the geocoding controller, the class GeocoderResolver concentrates the business rules and processing coordinate location information.

### Authentication

This application uses authenticate_or_request_with_http_token to allow access to looking for latitude and longitude for an address name.
If trying to access the geocoding endpoint without an access token, the user will receive a 401 Unauthorized response "HTTP Token: Access denied." 

### Consuming the API

To do requests you can use [Postman](https://www.getpostman.com/), a very Powerful application that can be used to deal with APIs.
If you wanna to use Postman, import the file [docs/geocoding.postman_collection.json](docs/geocoding.postman_collection.json) using the button "Import".

The examples below use CURL and the codes can be executed in Terminal Console. 

#### Creating an user

For the first time, it's necessary to create a new user and get his access token:

````
curl -X POST \
  http://localhost:3000/api/v1/users \
  -H 'content-type: application/json' \
  -d '{
"user": { "name" : "Leonardo Gomes da Silva"
}
}'
````

This request will return the token for the user, like to the following example:
````
{
    "id": 6,
    "name": "Leonardo Gomes da Silva",
    "token": "user_token_here"
}
````

#### Sending requests to the geocoding endpoint

The endpoint geocoding requires the GET parameter ?query_name="address to search"

Copy the token for the user and use it to send the request for the geocoding endpoint, following examples below:

##### checkpoint charlie
* Request
    
    ````
    curl -X GET \
      'http://localhost:3000/api/v1/geocoding?query_name=%22checkpoint%20charlie%22' \
      -H 'authorization: Token token=9c954067b27a1b06114dedca46903a19'
    ````

* Results
    ````
    [
        52.5074434,
        13.3903913
    ]
    ````
    
##### Francisco Muratori Street
* Request
    ````
    curl -X GET \
      'http://localhost:3000/api/v1/geocoding?query_name=%22Francisco%20Muratori%20Street%22' \
      -H 'authorization: Token token=9c954067b27a1b06114dedca46903a19'
    ````
* Results
    ````
    [
        -22.9155832,
        -43.1813885
    ]
    ````

#### Exceptions

* Invalid address

    Requesting the invalid address "aaaaaaaa":
    ````
    curl -X GET \
      curl -X GET \
        'http://localhost:3000/api/v1/geocoding?query_name=%22aaaaaaaa%22' \
        -H 'authorization: Token token=9c954067b27a1b06114dedca46903a19'
    ````
    Response:
    ````
    Status 404 Not Found
    {
        "error": "param is missing or the value is empty: geocoder_resolver"
    }
    ````
    
* Parameter missing

    Requests without parameter `` ?query_name="address to search" `` will return:

    ````
    {
        "error": "param is missing or the value is empty: query_name"
    }
    ````