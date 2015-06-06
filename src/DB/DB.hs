{-# LANGUAGE OverloadedStrings #-}

module DB.DB where


import Database.MongoDB


connectTo :: String -> IO Pipe
connectTo = connect . host


run :: Pipe -> Database -> Action IO a -> IO a
run pipe = access pipe master


doWithConnection :: (Pipe -> IO a) -> String -> IO a
doWithConnection dbAction hostName = do
  pipe <- connectTo hostName
  dbAction pipe


allDbs :: Pipe -> IO [Database]
allDbs pipe = run pipe "test" allDatabases



-- access pipe master "test" allCollections

-- connect :: I
-- conect = do

-- main :: IO ()
-- main = do
--     pipe <- connect (host "127.0.0.1")
--     e <- access pipe master "baseball" run
--     close pipe
--     print e
--
-- run :: Action IO ()
-- run = do
--     clearTeams
--     insertTeams
--     allTeams >>= printDocs "All Teams"
--     nationalLeagueTeams >>= printDocs "National League Teams"
--     newYorkTeams >>= printDocs "New York Teams"
--
