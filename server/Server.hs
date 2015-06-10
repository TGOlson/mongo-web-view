module Server where


import Web.Scotty
import Routes
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static


runWebServer :: IO ()
runWebServer = scotty 8000 $ do
  middleware logStdoutDev
  middleware $ staticPolicy (noDots >-> addBase "public")
  routes
