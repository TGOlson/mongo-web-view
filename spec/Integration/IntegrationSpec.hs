{-# LANGUAGE OverloadedStrings   #-}

module Integration.IntegrationSpec where


import Test.Hspec
import Data.Aeson
import Control.Lens ((^.))
import Network.Wreq
import Integration.Data
import Data.Aeson.Types
import Integration.Setup


mkUrl :: String -> String
mkUrl s = "http://localhost:8000" ++ s
-- mkUrl s = "http://api:8000" ++ s


shouldReturnJson :: IO (Maybe Value) -> [Pair] -> Expectation
shouldReturnJson maybeRes ps = maybeRes `shouldReturn` (Just $ object ps)


shouldReturnListContaining :: (Show a, Eq a) => IO (Maybe [a]) -> [a] -> Expectation
shouldReturnListContaining res xs = res >>= (\(Just ys) -> ys `shouldContain` xs)


postWithBody :: FromJSON a => String -> [Pair] -> IO (Maybe a)
postWithBody path body = do
  r <- post (mkUrl path) (toJSON $ object body)
  return $ decode (r ^. responseBody)


postBody :: [Pair]
postBody = [
    "host"     .= hostName,
    "username" .= String "test-admin",
    "password" .= String "password",
    "db"       .= testDb
    -- "domain"   .= hostName
  ]

-- mongodb://user:password@domain:port/dbname

-- POST /collections
-- POST /collections/:collection

main :: IO ()
main = hspec spec


spec :: Spec
spec = before_ seedTestDb $ do
  describe "POST /databases/:db" $ do
    it "should return a list of collections for the specified database" $
      postWithBody "/databases/test-db" postBody `shouldReturnListContaining` collections

    it "should return an error when no host is provided" $
      postWithBody "/databases/test-db" [] `shouldReturnJson` ["error" .= String "Must provide host"]


  describe "POST /databases/:db/:collection" $ do
    it "should return a list of docs for the specified collection" $
      postWithBody "/databases/test-db/test-collection-1" postBody `shouldReturn` Just testDocs

    it "should return an error when no host is provided" $
      postWithBody "/databases/test-db/test-collection-1" [] `shouldReturnJson` ["error" .= String "Must provide host"]
