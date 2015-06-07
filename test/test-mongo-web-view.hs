{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}


module Main where


import Control.Lens ((^.))
import Data.Aeson
import Test.HUnit
import Network.Wreq


mkUrl :: String -> String
mkUrl s = "http://localhost:3000" ++ s


expectedDatabases :: [String]
expectedDatabases = ["dummydb", "local"]


testGetDatabases :: IO Test
testGetDatabases = do
  r <- get (mkUrl "/databases")
  let result = decode (r ^. responseBody) :: Maybe [String]
  return . TestCase $ assertEqual
    "Should return a list of databases" (Just expectedDatabases) result


expectedCollections :: [String]
expectedCollections = ["migrations", "system.indexes"]


testGetCollections :: IO Test
testGetCollections = do
  r <- get (mkUrl "/databases/dummydb")
  let result = decode (r ^. responseBody) :: Maybe [String]
  return . TestCase $ assertEqual
    "Should return a list of collections in a database" (Just expectedCollections) result


main :: IO Counts
main = do
  test1 <- testGetDatabases
  test2 <- testGetCollections
  runTestTT $ TestList [test1, test2]
