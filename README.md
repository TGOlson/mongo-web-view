# Mongo Web View

Explore a mongo database with a simple web UI.

Made with Haskell.

Runs in a linked docker container system using Docker Compose.

Run with docker and docker compose

```
$ docker-compose build
$ docker-compose up -d app
```

Go to `<boot2docker ip>:8000` to check it out.

Run the tests

```
$ docker-compose run test
Running test...

Integration.Integration
  POST /databases
    should return a list of databases
    should return an error when no host is provided
  POST /databases/:db
    should return a list of collections for the specified database
    should return an error when no host is provided
  POST /databases/:db/:collection
    should return a list of docs for the specified collection
    should return an error when no host is provided

Finished in 1.2840 seconds
6 examples, 0 failures
```
