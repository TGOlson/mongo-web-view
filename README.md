# Mongo Web View

Explore a mongo database with a simple web UI.

Made with Haskell.

Haskell web server with an Angular Material front-end. Deployed using Docker and Docker Compose to run distinct processes in individual containers. Uses Nginx server for serving assets and forwarding API requests.

Run with docker and docker compose

```
$ docker-compose build
$ docker-compose up -d proxy
```

Go to `<boot2docker ip>:8080` to check it out.

Run the tests

```
$ docker-compose run integrationtest
Running integration-test...

Integration.Integration
  POST /collections
    should return a list of collections for the specified database
    should return an error when no uri is provided
    should return an error when an invalid uri is provided
  POST /collections/:collection
    should return a list of docs for the specified collection
    should return an error when an invalid uri is provided

Finished in 8.1496 seconds
5 examples, 0 failures
```
