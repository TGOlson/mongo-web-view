{-# LANGUAGE OverloadedStrings #-}

module Web.Utils where


import Web.Scotty
import Data.Aeson hiding (json)


toJsonResults :: ToJSON a => a -> ActionM ()
toJsonResults = json . formatResults


formatResults :: ToJSON a => a -> Value
formatResults x = object ["results" .= x]
