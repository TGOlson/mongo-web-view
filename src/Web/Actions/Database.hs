{-# LANGUAGE OverloadedStrings #-}

module Web.Actions.Database where


import Database.MongoDB


import DB.DB
import Data.Text
import Web.Spock.Safe
-- import Data.Aeson hiding (json)
import Control.Monad.Trans (liftIO)


getAllDatabases :: String -> ActionT IO ()
getAllDatabases hostName = do
  dbs <- liftIO $ doWithConnection allDbs hostName
  text . pack $ show dbs
