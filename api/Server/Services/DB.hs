{-# LANGUAGE OverloadedStrings #-}

module Services.DB where


import Database.MongoDB hiding (host)
import Data.Aeson.Bson()
import Services.Parser
import Types.ApiError
import Data.Text (pack)



data MongoConfig = MongoConfig {
    username :: Username,
    password :: Password,
    host     :: String,
    dbname   :: Database
  }
  deriving (Show, Eq)


parseMongoConfig :: String -> Either ApiError MongoConfig
parseMongoConfig = fmap uriPartsToMongoConfig . parseMongoUriParts


uriPartsToMongoConfig :: MongoUriParts -> MongoConfig
uriPartsToMongoConfig (user, pw, domain, port, db) =
  MongoConfig {
    username = pack user,
    password = pack pw  ,
    host     = domain ++ ":" ++ show port,
    dbname   = pack db
  }


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
