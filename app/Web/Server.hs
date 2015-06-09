module Web.Server where


import Web.Scotty
import Web.Routes


runWebServer :: IO ()
runWebServer = scotty 8000 routes
