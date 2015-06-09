{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}


module IntegrationSpec where


import Test.Hspec
import Data.Aeson
import Control.Lens ((^.))
import Network.Wreq


mkUrl :: String -> String
mkUrl s = "http://localhost:3000" ++ s


expectedDatabases :: Maybe [String]
expectedDatabases = Just ["dummydb", "local"]


expectedCollections :: Maybe [String]
expectedCollections = Just ["migrations", "system.indexes"]


getRespondBody :: FromJSON a => String -> IO (Maybe a)
getRespondBody url = do
  r <- get (mkUrl url)
  return $ decode (r ^. responseBody)


main :: IO ()
main = hspec $ do
  describe "GET /databases" $
    it "should return a list of databases" $
      getRespondBody "/databases" `shouldReturn` expectedDatabases

  describe "GET /databases/:db" $
    it "should return a list of collections for the specified database" $
      getRespondBody "/databases/dummydb" `shouldReturn` expectedCollections
