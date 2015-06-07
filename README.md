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
$ runhaskell test/test-mongo-web-view.hs
Cases: 2  Tried: 2  Errors: 0  Failures: 0
Counts {cases = 2, tried = 2, errors = 0, failures = 0}
``

TODO: `cabal test`

http://hspec.github.io/
https://pbrisbin.com/posts/automated_unit_testing_in_haskell/
