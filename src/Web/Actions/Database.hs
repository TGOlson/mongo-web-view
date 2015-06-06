{-# LANGUAGE OverloadedStrings #-}

module Web.Actions.Database where


import Web.Scotty
import Database.MongoDB
import Web.Actions.Utils
import DB.DB
import Control.Monad.Trans (liftIO)
import Data.Aeson hiding (json)


getAllDatabases :: String -> ActionM ()
getAllDatabases hostName = formatList $ runActionWithConnection allDatabases hostName "test"


getAllCollections :: String -> Database -> ActionM ()
getAllCollections hostName = formatList . runActionWithConnection allCollections hostName


getAllDocuments :: String -> Database -> Collection -> IO [Document]
getAllDocuments hostName dbName collectionName = runActionWithConnection (findAll collectionName) hostName dbName


formatList :: ToJSON a => IO [a] -> ActionM ()
formatList xs = toJsonAction =<< liftIO xs


formatDocs :: Show a => IO [a] -> ActionM ()
formatDocs xs = toJsonAction =<< liftIO (fmap (map show) xs)


showAllDocs :: String -> Database -> Collection -> ActionM ()
showAllDocs hostName dbName = formatDocs . getAllDocuments hostName dbName
