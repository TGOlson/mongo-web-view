{-# LANGUAGE OverloadedStrings #-}

module Integration.Data where


import Database.MongoDB hiding (String)
import Data.Aeson
import Data.Aeson.Types
import Control.Applicative
import Control.Monad


testHost :: String
testHost = "ds043972.mongolab.com:43972"


testDb :: Database
testDb = "test-db"


testUser :: Username
testUser = "test-admin"


testPw :: Username
testPw = "password"


configError :: [Pair]
configError = ["error" .= String "Must provide all required config fields."]


collections :: [Collection]
collections = [
    "test-collection-1",
    "test-collection-2"
  ]


-- Create test doc data type to resolve issue of aeson versions between aeson-bson and wreq
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
