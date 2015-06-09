{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleInstances   #-}

module Integration.Data where


import Database.MongoDB
import Data.Aeson hiding (String)
import Control.Applicative
import Control.Monad


-- Create test doc data type to resolve issue of aeson versions
-- between aeson-bson and wreq
data TestDoc = TestDoc { title :: String } deriving (Show, Eq)


instance FromJSON TestDoc where
  parseJSON (Object v) = TestDoc <$> v .: "title"
  parseJSON _ = mzero


testDocs :: [TestDoc]
testDocs = [
    TestDoc "Dummy Doc 1",
    TestDoc "Dummy Doc 2"
  ]


docs :: [Document]
docs = map (\(TestDoc t) -> ["title" =: t]) testDocs


databases :: [Database]
databases = [
    "_testdb",
    "xemptydb"
  ]


collections :: [Collection]
collections = [
    "_testcollection",
    "system.indexes",
    "xemptycollection"
  ]
