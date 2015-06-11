{-# LANGUAGE OverloadedStrings #-}

module Routes where


import Web.Scotty
import Services.DB
import Control.Monad.Trans (liftIO)
import Data.Aeson hiding (json)
import Data.Aeson.Types


routes :: ScottyM ()
routes = do
  post "/databases" $ doWithHost getAllDatabases

  post "/databases/:db" $ do
    db <- param "db"
    doWithHost $ getAllCollections db

  post "/databases/:db/:collection" $ do
    db <- param "db"
    collection <- param "collection"

    doWithHost $ getAllDocuments db collection


getHost ::ActionM (Maybe String)
getHost = do
  b <- jsonData
  return $ parseMaybe (.: "host") b


doWithHost :: ToJSON a => (String -> IO a) -> ActionM ()
doWithHost f = do
  maybeHost <- getHost

  case maybeHost of
    Nothing -> json $ object ["error" .= String "Must provide host"]
    (Just host) -> json =<< liftIO (f host)
