{-# LANGUAGE OverloadedStrings #-}

module Integration.Setup where


import Integration.Data
import Database.MongoDB


seedTestDb :: IO ()
seedTestDb = do
  -- pipe <- connect (host "127.0.0.1")
  pipe <- connect (host "db")

  let run = access pipe master testDb

  _ <- run (dropDatabase testDb)
  mapM_ (run . createCollection []) collections
  run $ insertMany_ (head collections) docs
