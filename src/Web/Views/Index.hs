{-# LANGUAGE OverloadedStrings #-}

module Web.Views.Index where


import Web.Spock.Safe


index :: ActionT IO ()
index = html "<h1>Hello!</h1>"
