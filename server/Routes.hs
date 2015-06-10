{-# LANGUAGE OverloadedStrings #-}

module Routes where


import Web.Scotty
import Actions.Database
import Control.Monad.Trans (liftIO)


dbName :: String
-- dbName = "db"
dbName = "localhost"

routes :: ScottyM ()
routes = do
  get "/" $ file "public/index.html"

  get "/databases" $ do
      dbs <- liftIO $ getAllDatabases dbName
      json dbs

  get "/databases/:db" $ do
      db <- param "db"
      collections <- liftIO $ getAllCollections dbName db
      json collections

  get "/databases/:db/:collection" $ do
      db <- param "db"
      collection <- param "collection"
      docs <- liftIO $ getAllDocuments dbName db collection
      json docs
