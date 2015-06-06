{-# LANGUAGE OverloadedStrings #-}

module Web.Routes where


import Web.Scotty
import Web.Utils
import Web.Actions.Database
import Control.Monad.Trans (liftIO)
import Data.AesonBson


routes :: ScottyM ()
routes = do
  get "/" $ file "src/Web/Views/index.html"

  get "/databases" $ do
      dbs <- liftIO $ getAllDatabases "127.0.0.1"
      toJsonResults dbs

  get "/databases/:db" $ do
      db <- param "db"
      collections <- liftIO $ getAllCollections "127.0.0.1" db
      toJsonResults collections

  get "/databases/:db/:collection" $ do
      db <- param "db"
      collection <- param "collection"
      docs <- liftIO $ getAllDocuments "127.0.0.1" db collection
      json . show $ map aesonify docs
