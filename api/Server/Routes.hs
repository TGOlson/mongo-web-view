{-# LANGUAGE OverloadedStrings #-}

module Routes where


import Web.Scotty
import Services.DB
import Control.Monad.Trans (liftIO)
import Data.Aeson hiding (json)


routes :: ScottyM ()
routes = do
  post "/collections" $ doWithMongoConfig getAllCollections

  post "/collections/:collection" $ do
    collection <- param "collection"
    doWithMongoConfig $ getAllDocuments collection


parseMongoConfig ::ActionM (Maybe MongoConfig)
parseMongoConfig = do
  b <- body
  return $ decode b


doWithMongoConfig :: ToJSON a => (MongoConfig -> IO a) -> ActionM ()
doWithMongoConfig f = do
  maybeConfig <- parseMongoConfig

  case maybeConfig of
    Nothing -> json $ object ["error" .= String "Must provide all required config fields."]
    (Just config) -> json =<< liftIO (f config)
