{-# LANGUAGE OverloadedStrings #-}

module Web.Actions.Database where


import Database.MongoDB


import DB.DB
import Data.Text
import Web.Spock.Safe
import Control.Monad.Trans (liftIO)


toTextAction :: Show a => IO [a] -> ActionT IO ()
toTextAction xs = liftIO xs >>= (text . pack . show)


showAction :: Show a => Action IO [a] -> String -> Database -> ActionT IO ()
showAction action hostName = toTextAction . runActionWithConnection action hostName


getAllDatabases :: String -> ActionT IO ()
getAllDatabases hostName = showAction allDatabases hostName "test"


getAllCollections :: String -> Database -> ActionT IO ()
getAllCollections = showAction allCollections
