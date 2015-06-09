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

Run tests

```
$ runhaskell test/IntegrationSpec.hs
GET /databases/:db
  should return a list of collections for the specified database

Finished in 0.0484 seconds
1 example, 0 failures
``

TODO: `cabal test`

http://hspec.github.io/
https://pbrisbin.com/posts/automated_unit_testing_in_haskell/
