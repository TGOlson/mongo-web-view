{-# LANGUAGE OverloadedStrings #-}

module Web.Routes where


import Web.Scotty
import Web.Actions.Database
import Control.Monad.Trans (liftIO)
import Data.Aeson.Bson


routes :: ScottyM ()
routes = do
  get "/" $ file "src/Web/Views/index.html"

  get "/databases" $ do
      dbs <- liftIO $ getAllDatabases "127.0.0.1"
      json dbs

  get "/databases/:db" $ do
      db <- param "db"
      collections <- liftIO $ getAllCollections "127.0.0.1" db
      json collections

  get "/databases/:db/:collection" $ do
      db <- param "db"
      collection <- param "collection"
      docs <- liftIO $ getAllDocuments "127.0.0.1" db collection
      json $ map toAeson docs
