{-# LANGUAGE OverloadedStrings #-}

module Web.Actions.Hello where


import Web.Spock.Safe
import Data.Aeson hiding (json)


hello :: String -> ActionT IO ()
hello name = json $ object ["sup" .= name]
