# Mongo Web View

Explore a mongo database with a simple web UI.

Made with Haskell.

Runs in a linked docker container system using Docker Compose.

Run with docker and docker compose

```
$ docker-compose build
$ docker-compose up server
```

Run the tests

```
$ docker-compose up test
```

Go to `<boot2docker ip>:8000` to check it out.

To run without docker:

Install Dependencies

```
$ cabal install --only-dependencies
```

Run Server

```
$ cabal run app
```

Go to `localhost:8000` to check it out.

Run tests

```
$ cabal run test
Integration.Integration
  GET /databases
    should return a list of databases
  GET /databases/:db
    should return a list of collections for the specified database
  GET /databases/:db/:collection
    should return a list of docs for the specified collection

Finished in 0.5316 seconds
3 examples, 0 failures
```
