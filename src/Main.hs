module Main where


import Web.Spock.Safe

import Web.Routes


main :: IO ()
main = runSpock 3000 $ spockT id routes
