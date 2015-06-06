module Web.Server where


import Web.Scotty
import Web.Routes


runWebServer :: IO ()
runWebServer = scotty 3000 routes
