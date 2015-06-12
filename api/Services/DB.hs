{-# LANGUAGE OverloadedStrings #-}

module Services.DB where


import Database.MongoDB
import Data.Aeson.Bson()

-- 
-- run :: Action IO a -> Database -> String -> IO a
-- run action db hostName = do
--   pipe <- connect (readHostPort hostName)
--   -- pipe <- connect (host hostName)
--   access pipe master db action

--
runWithAuth :: Action IO a -> Database -> String -> IO a
runWithAuth action db hostName = do
  pipe <- connect (readHostPort hostName)
  let run = access pipe master db
  run (auth "test-admin" "password") >> run action


getAllCollections :: Database -> String -> IO [Collection]
getAllCollections = runWithAuth allCollections


getAllDocuments :: Database -> Collection -> String -> IO [Document]
getAllDocuments db collectionName = runWithAuth (findAll collectionName) db


findAll :: Collection -> Action IO [Document]
findAll collectionName = rest =<< find (select [] collectionName)
