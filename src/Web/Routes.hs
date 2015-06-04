{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Web.Routes where


import Web.Spock.Safe

import Web.Actions.Hello
import Web.Views.Index


routes :: SpockT IO ()
routes = do
  get "" index
  get "hello" $ hello "User"
  get ("hello" <//> var) $ \name -> hello name
