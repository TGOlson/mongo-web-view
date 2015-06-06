{-# LANGUAGE OverloadedStrings #-}

module DB.DB where


import Database.MongoDB


connectTo :: String -> IO Pipe
connectTo = connect . host


runAction :: Action IO a -> Database -> Pipe -> IO a
runAction action dbName pipe = access pipe master dbName action


withConnection :: (Pipe -> IO a) -> String -> IO a
withConnection dbAction hostName = connectTo hostName >>= dbAction


runActionWithConnection :: Action IO a -> String -> Database -> IO a
runActionWithConnection action hostName dbName =  withConnection (runAction action dbName) hostName
