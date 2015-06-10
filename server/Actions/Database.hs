{-# LANGUAGE OverloadedStrings #-}

module Actions.Database where


import Database.MongoDB
import Services.DB


getAllDatabases :: String -> IO [Database]
getAllDatabases hostName = runActionWithConnection allDatabases hostName "test"


getAllCollections :: String -> Database -> IO [Collection]
getAllCollections = runActionWithConnection allCollections


getAllDocuments :: String -> Database -> Collection -> IO [Document]
getAllDocuments hostName dbName collectionName = runActionWithConnection (findAll collectionName) hostName dbName
