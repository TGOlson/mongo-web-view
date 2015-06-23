{-# LANGUAGE OverloadedStrings #-}

module Integration.Setup where


import Integration.Data
import Database.MongoDB


seedTestDb :: IO ()
seedTestDb = do
  pipe <- connect (readHostPort testHost)

  let run = access pipe master testDb

  run (auth testUser testPw) >>
    mapM_ (run . dropCollection) collections >>
    mapM_ (\c -> run (insertMany_ c docs)) collections

  close pipe
