{-# LANGUAGE OverloadedStrings #-}

module Web.Actions.Utils where


import Web.Scotty
import Data.Aeson hiding (json)


toJsonAction :: ToJSON a => a -> ActionM ()
toJsonAction = json . formatResults


formatResults :: ToJSON a => a -> Value
formatResults x = object ["results" .= x]
