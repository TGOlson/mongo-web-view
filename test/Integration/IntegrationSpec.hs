{-# LANGUAGE OverloadedStrings   #-}

module Integration.IntegrationSpec where


import Test.Hspec
import Data.Aeson
import Data.ByteString.Lazy.Char8 (pack)
import Network.HTTP
import Integration.Data
import Integration.Setup


mkUrl :: String -> String
mkUrl s = "http://192.168.59.103:8000" ++ s
-- mkUrl s = "http://localhost:8000" ++ s


getParsedBody :: FromJSON a => String -> IO (Maybe a)
getParsedBody url = do
  r <- simpleHTTP $ getRequest (mkUrl url)
  rsp <- getResponseBody r
  return . decode $ pack rsp


shouldReturnJust :: (Show a, Eq a) => IO (Maybe a) -> a -> Expectation
shouldReturnJust io x = io `shouldReturn` Just x


main :: IO ()
main = hspec spec


spec :: Spec
spec = before_ seedTestDb $ do
  describe "GET /databases" $
    it "should return a list of databases" $

      -- only check that the test-db is included in the response
      -- asserting against all dbs requires first dropping all dbs
      getParsedBody "/databases" >>= (\(Just dbs) -> testDb `elem` dbs `shouldBe` True)

  describe "GET /databases/:db" $
    it "should return a list of collections for the specified database" $
      getParsedBody "/databases/_testdb" `shouldReturnJust` collections

  describe "GET /databases/:db/:collection" $
    it "should return a list of docs for the specified collection" $
      getParsedBody "/databases/_testdb/_testcollection" `shouldReturnJust` testDocs
