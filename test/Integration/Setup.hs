{-# LANGUAGE OverloadedStrings #-}

module Integration.Setup where


import Integration.Data
import Database.MongoDB


seedTestDb :: IO ()
seedTestDb = do
  pipe <- connect (host "localhost")
  -- pipe <- connect (host "db")

  let run = access pipe master testDb

  _ <- run (dropDatabase testDb)
  mapM_ (run . createCollection []) collections
  run $ insertMany_ (head collections) docs
