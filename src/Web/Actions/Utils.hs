{-# LANGUAGE OverloadedStrings #-}

module Web.Actions.Utils where


import Web.Spock.Safe
import Data.Aeson hiding (json)


toJsonAction :: ToJSON a => a -> ActionT IO ()
toJsonAction = json . formatResults


formatResults :: ToJSON a => a -> Value
formatResults x = object ["results" .= x]
