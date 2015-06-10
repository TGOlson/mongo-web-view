module Services.DB where


import Database.MongoDB
import Data.Aeson.Bson()


connectTo :: String -> IO Pipe
connectTo = connect . host


runAction :: Action IO a -> Database -> Pipe -> IO a
runAction action dbName pipe = access pipe master dbName action


withConnection :: (Pipe -> IO a) -> String -> IO a
withConnection dbAction hostName = dbAction =<< connectTo hostName


runActionWithConnection :: Action IO a -> String -> Database -> IO a
runActionWithConnection action hostName dbName = withConnection (runAction action dbName) hostName


findAll :: Collection -> Action IO [Document]
findAll collectionName = rest =<< find (select [] collectionName)
