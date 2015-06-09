{-# LANGUAGE OverloadedStrings #-}

module Integration.Setup where


import Integration.Data
import Database.MongoDB


run :: Pipe -> Database -> Action IO a -> IO a
run pipe = access pipe master


dropDb :: Pipe -> Database -> IO Document
dropDb pipe db = run pipe "test" $ dropDatabase db


makeCollection :: Pipe -> Database -> Collection -> IO Document
makeCollection pipe db col = run pipe db $ createCollection [] col


seedDb :: Pipe -> Database -> IO ()
seedDb pipe db = do
  mapM_ (makeCollection pipe db) collections
  run pipe db $ insertMany_ (head collections) docs


runSeed :: IO ()
runSeed = do
  pipe <- connect (host "127.0.0.1")
  dbs <- run pipe "test" allDatabases
  mapM_ (dropDb pipe) dbs
  mapM_ (seedDb pipe) databases
