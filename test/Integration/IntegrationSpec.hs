{-# LANGUAGE OverloadedStrings   #-}

module Integration.IntegrationSpec where


import Test.Hspec
import Data.Aeson
import Data.ByteString.Lazy.Char8
import Network.HTTP
import Integration.Data
import Integration.Setup


mkUrl :: String -> String
mkUrl s = "http://localhost:3000" ++ s


getParsedBody :: FromJSON a => String -> IO (Maybe a)
getParsedBody url = do
  r <- simpleHTTP $ getRequest (mkUrl url)
  rsp <- getResponseBody r
  return . decode $ pack rsp


main :: IO ()
main = hspec spec


spec :: Spec
spec = before_ runSeed $ do
  describe "GET /databases" $
    it "should return a list of databases" $
      getParsedBody "/databases" `shouldReturn` Just databases

  describe "GET /databases/:db" $
    it "should return a list of collections for the specified database" $
      getParsedBody "/databases/_testdb" `shouldReturn` Just collections

  describe "GET /databases/:db/:collection" $
    it "should return a list of docs for the specified collection" $
      getParsedBody "/databases/_testdb/_testcollection" `shouldReturn` Just testDocs
