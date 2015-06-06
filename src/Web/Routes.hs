{-# LANGUAGE OverloadedStrings #-}

module Web.Routes where


import Web.Scotty
import Web.Actions.Database


routes :: ScottyM ()
routes = do
  get "/" $ file "src/Web/Views/index.html"

  get "/databases" $ getAllDatabases "127.0.0.1"

  get "/databases/:db" $ do
      db <- param "db"
      getAllCollections "127.0.0.1" db

  get "/databases/:db/:collection" $ do
      db <- param "db"
      collection <- param "collection"
      showAllDocs "127.0.0.1" db collection
