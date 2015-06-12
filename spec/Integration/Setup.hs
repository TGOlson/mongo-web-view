{-# LANGUAGE OverloadedStrings #-}

module Integration.Setup where


import Integration.Data
import Database.MongoDB

--
-- runWithAuth :: Pipe -> Action IO a -> IO a
-- runWithAuth pipe action = access pipe master testDb (auth "test-admin" "password") >> access pipe master testDb action
--

seedTestDb :: IO ()
seedTestDb = do
  pipe <- connect (readHostPort hostName)
  --
  let run = access pipe master testDb

  run (auth "test-admin" "password") >>
    mapM_ (run . dropCollection) collections >>
    mapM_ (\c -> run (insertMany_ c docs)) collections

  close pipe
  -- return ()
