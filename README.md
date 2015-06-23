# Mongo Web View

Explore a mongo database with a simple web UI.

Made with Haskell.

Runs in a linked docker container system using Docker Compose.

Run with docker and docker compose

```
$ docker-compose build
$ docker-compose up -d proxy
```

Go to `<boot2docker ip>:8000` to check it out.

Run the tests

```
$ docker-compose run test
Running test...

Integration.Integration
  POST /collections
    should return a list of collections for the specified database
    should return an error when no config is provided
  POST /collections/:collection
    should return a list of docs for the specified collection
    should return an error when no config is provided

Finished in 7.5418 seconds
4 examples, 0 failures
```
