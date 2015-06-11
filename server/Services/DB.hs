{-# LANGUAGE OverloadedStrings #-}

module Services.DB where


import Database.MongoDB
import Data.Aeson.Bson()


run :: Action IO a -> Database -> String -> IO a
run action db hostName = do
  pipe <- connect (host hostName)
  access pipe master db action


getAllDatabases :: String -> IO [Database]
getAllDatabases = run allDatabases "test"


getAllCollections :: Database -> String -> IO [Collection]
getAllCollections = run allCollections


getAllDocuments :: Database -> Collection -> String -> IO [Document]
getAllDocuments db collectionName = run (findAll collectionName) db


findAll :: Collection -> Action IO [Document]
findAll collectionName = rest =<< find (select [] collectionName)
