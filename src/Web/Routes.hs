{-# LANGUAGE OverloadedStrings #-}

module Web.Routes where


import Web.Spock.Safe
import Web.Actions.Database


routes :: SpockT IO ()
routes = do
  get "/" $ file "text/html" "src/Web/Views/index.html"

  get  "databases"                    $ getAllDatabases   "127.0.0.1"
  get ("databases" <//> var)          $ getAllCollections "127.0.0.1"
  get ("databases" <//> var <//> var) $ showAllDocs       "127.0.0.1"
