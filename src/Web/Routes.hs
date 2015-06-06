{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Web.Routes where


import Web.Spock.Safe
import Web.Actions.Hello
import Web.Actions.Database


routes :: SpockT IO ()
routes = do
  get "" $ file "text/html" "src/Web/Views/index.html"

  get "databases" $ getAllDatabases "127.0.0.1"
  get ("databases" <//> var) $ \dbName -> getAllCollections "127.0.0.1" dbName

  get "hello" $ hello "User"
  get ("hello" <//> var) $ \(name :: String) -> hello name
