{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}

module Routes where


import Web.Scotty
import Services.DB
import Control.Monad.Trans (liftIO)
import Data.Aeson hiding (json, Error)
import Data.Aeson.Types (parseMaybe)
import Types.ApiError
import Types.ApiResponse
import Utils
import qualified Data.Traversable as T


routes :: ScottyM ()
routes = do
  post "/collections" $ doWithMongoConfig getAllCollections

  post "/collections/:collection" $ do
    collection <- param "collection"
    doWithMongoConfig $ getAllDocuments collection


parseMongoUri :: Object -> Maybe String
parseMongoUri = parseMaybe (.: "mongoUri")


getMongoConfig :: Maybe String -> Either ApiError MongoConfig
getMongoConfig uri = maybeToEither (ApiError "Must provide mongo uri.") uri >>= parseMongoConfig


doWithMongoConfig :: ToJSON a => (MongoConfig -> IO a) -> ActionM ()
doWithMongoConfig f = do
  b <- jsonData

  let config = getMongoConfig $ parseMongoUri b
  result <- liftIO . T.sequence $ fmap f config

  json $ ApiResponse result
