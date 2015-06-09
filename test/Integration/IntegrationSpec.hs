{-# LANGUAGE OverloadedStrings   #-}

module Integration.IntegrationSpec where


import Test.Hspec
import Data.Aeson
import Control.Lens ((^.))
import Network.Wreq
import Integration.Data
import Integration.Setup


mkUrl :: String -> String
mkUrl s = "http://localhost:3000" ++ s


getRespondBody :: FromJSON a => String -> IO (Maybe a)
getRespondBody url = do
  r <- get (mkUrl url)
  return $ decode (r ^. responseBody)


main :: IO ()
main = hspec spec


spec :: Spec
spec = before_ runSeed $ do
  describe "GET /databases" $
    it "should return a list of databases" $
      getRespondBody "/databases" `shouldReturn` Just databases

  describe "GET /databases/:db" $
    it "should return a list of collections for the specified database" $
      getRespondBody "/databases/_testdb" `shouldReturn` Just collections

  describe "GET /databases/:db/:collection" $
    it "should return a list of docs for the specified collection" $
      getRespondBody "/databases/_testdb/_testcollection" `shouldReturn` Just testDocs
