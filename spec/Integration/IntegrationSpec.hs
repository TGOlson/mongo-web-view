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
-- mkUrl s = "http://api:8000" ++ s
mkUrl s = "http://localhost:8000" ++ s


postBody :: [Pair]
postBody = ["mongoUri" .= testUri]


shouldReturnJson :: IO (Maybe Value) -> [Pair] -> Expectation
shouldReturnJson maybeRes ps = maybeRes `shouldReturn` (Just $ object ps)


shouldReturnListContaining :: (Show a, Eq a) => IO (Maybe [a]) -> [a] -> Expectation
shouldReturnListContaining res xs = res >>= (\(Just ys) -> ys `shouldContain` xs)


postWithBody :: FromJSON a => String -> [Pair] -> IO (Maybe a)
postWithBody path body = do
  r <- post (mkUrl path) (toJSON $ object body)
  return $ decode (r ^. responseBody)


main :: IO ()
main = hspec spec


spec :: Spec
spec = before_ seedTestDb $ do
  describe "POST /collections" $ do
    it "should return a list of collections for the specified database" $
      postWithBody "/collections" postBody `shouldReturnListContaining` collections

    it "should return an error when no is provided" $
      postWithBody "/collections" [] `shouldReturnJson`
        ["error" .= String "Must provide mongo uri."]

    it "should return an error when an invalid uri is provided" $
      postWithBody "/collections" ["mongoUri" .= String "foo@bar"] `shouldReturnJson`
        ["error" .= String "(line 1, column 1):\nunexpected \"f\"\nexpecting \"mongodb://\""]


  describe "POST /collections/:collection" $ do
    it "should return a list of docs for the specified collection" $
      postWithBody "/collections/test-collection-1" postBody `shouldReturn` Just testDocs

    it "should return an error when an invalid uri provided" $
      postWithBody "/collections/test-collection-1" [] `shouldReturnJson`
        ["error" .= String "Must provide mongo uri."]
