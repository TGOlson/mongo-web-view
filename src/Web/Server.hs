module Web.Server where


import Web.Spock.Safe
import Web.Routes


runWebServer :: IO ()
runWebServer = runSpock 3000 $ spockT id routes
