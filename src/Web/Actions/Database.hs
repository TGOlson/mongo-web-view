{-# LANGUAGE OverloadedStrings #-}

module Web.Actions.Database where


import Web.Spock.Safe
import Database.MongoDB
import Web.Actions.Utils
import DB.DB
import Control.Monad.Trans (liftIO)
import Data.Aeson hiding (json)


getAllDatabases :: String -> ActionT IO ()
getAllDatabases hostName = formatList $ runActionWithConnection allDatabases hostName "test"


getAllCollections :: String -> Database -> ActionT IO ()
getAllCollections hostName = formatList . runActionWithConnection allCollections hostName


getAllDocuments :: String -> Database -> Collection -> IO [Document]
getAllDocuments hostName dbName collectionName = runActionWithConnection (findAll collectionName) hostName dbName


formatList :: ToJSON a => IO [a] -> ActionT IO ()
formatList xs = toJsonAction =<< liftIO xs


formatDocs :: Show a => IO [a] -> ActionT IO ()
formatDocs xs = toJsonAction =<< liftIO (fmap (map show) xs)


showAllDocs :: String -> Database -> Collection -> ActionT IO ()
showAllDocs hostName dbName = formatDocs . getAllDocuments hostName dbName
