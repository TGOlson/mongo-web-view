{-# LANGUAGE OverloadedStrings #-}

module Routes where


import Web.Scotty
import Services.DB
import Control.Monad.Trans (liftIO)
import Data.Aeson hiding (json, Error)
import Data.Aeson.Types hiding (Error)
import Types.Error


routes :: ScottyM ()
routes = do
  post "/collections" $ doWithMongoConfig getAllCollections

  post "/collections/:collection" $ do
    collection <- param "collection"
    doWithMongoConfig $ getAllDocuments collection


parseMongoUri :: ActionM (Maybe String)
parseMongoUri = do
  b <- jsonData
  return $ parseMaybe (.: "mongoUri") b


getMongoConfig :: ActionM (Either Error MongoConfig)
getMongoConfig = do
  maybeUri <- parseMongoUri

  return $ case maybeUri of
    Nothing -> Left $ Error "Must provide mongo uri."
    (Just uri) -> parseMongoConfig uri


doWithMongoConfig :: ToJSON a => (MongoConfig -> IO a) -> ActionM ()
doWithMongoConfig f = do
  eitherConfig <- getMongoConfig

  case eitherConfig of
    (Left (Error msg)) -> json $ object ["error" .= msg]
    (Right config) -> json =<< liftIO (f config)
