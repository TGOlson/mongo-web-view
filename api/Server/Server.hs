module Server where


import Web.Scotty
import Routes
import Network.Wai.Middleware.RequestLogger


runWebServer :: IO ()
runWebServer = scotty 8000 $ do
  middleware logStdoutDev
  routes
