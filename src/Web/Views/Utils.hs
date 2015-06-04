{-# LANGUAGE OverloadedStrings #-}

module Web.Views.Utils where


import Web.Spock.Safe


renderView :: FilePath -> ActionT IO ()
renderView fileName = file "text/html" ("src/Web/Views/" ++ fileName)
