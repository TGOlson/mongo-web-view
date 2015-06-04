{-# LANGUAGE OverloadedStrings #-}

module Web.Routes where


import Web.Spock.Safe
import Web.Actions.Hello
import Web.Views.Utils


routes :: SpockT IO ()
routes = do
  get "" $ renderView "index.html"
  get "hello" $ hello "User"
  get ("hello" <//> var) $ \name -> hello name
