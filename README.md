# Mongo Web View

Explore a mongo database with a simple web UI.

Made with Haskell.

Install Dependencies

```
$ cabal install --only-dependencies
```

Run Server

```
$ cabal run
```

Go to `localhost:3000` to check it out.

Or, build with docker

```
$ docker build -t mongo-web-view .
$ docker run -i -t -d -p 8000:3000 mongo-web-view
```

Go to `<boot2docker ip>:8000` to check it out.

Run tests

```
$ cabal install --enable-tests
$ cabal test
Running 1 test suites...
Test suite spec: RUNNING...
Test suite spec: PASS
``
