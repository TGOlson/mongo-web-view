{-# LANGUAGE OverloadedStrings #-}

module Services.DB where


import Database.MongoDB hiding (host)
import Data.Aeson.Bson()
import Data.Aeson
import Control.Monad
import Control.Applicative


data MongoConfig = MongoConfig {
    host     :: String,
    dbname   :: Database,
    username :: Username,
    password :: Password
  }


instance FromJSON MongoConfig where
    parseJSON (Object v) = MongoConfig <$>
                           v .: "host" <*>
                           v .: "dbname" <*>
                           v .: "username" <*>
                           v .: "password"
    parseJSON _          = mzero


makePipe :: MongoConfig -> IO Pipe
makePipe = connect . readHostPort . host


authenticate :: MongoConfig -> Action IO Bool
authenticate config = auth (username config) (password config)


runWithAuth :: Action IO a -> MongoConfig -> IO a
runWithAuth action config = do
  pipe <- makePipe config
  let run = access pipe master (dbname config)

  run (authenticate config) >> run action


getAllCollections :: MongoConfig -> IO [Collection]
getAllCollections = runWithAuth allCollections


getAllDocuments :: Collection -> MongoConfig -> IO [Document]
getAllDocuments collection = runWithAuth (findAll collection)


findAll :: Collection -> Action IO [Document]
findAll collectionName = rest =<< find (select [] collectionName)
