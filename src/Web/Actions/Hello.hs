{-# LANGUAGE OverloadedStrings #-}

module Web.Actions.Hello where


import Data.Text
import Web.Spock.Safe
import Data.Aeson hiding (json)


hello :: Text -> ActionT IO ()
hello name = json $ object ["sup" .= name]
