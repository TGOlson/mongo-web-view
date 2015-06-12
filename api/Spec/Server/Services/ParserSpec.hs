{-# LANGUAGE OverloadedStrings   #-}

module Server.Services.ParserSpec where


import Test.Hspec
import Services.Parser
import Data.List


main :: IO ()
main = hspec spec


connectionString :: String
connectionString = "mongodb://user:password@domain:port/dbname"


shouldHaveParseError :: Show a => Either a b -> [String] -> Expectation
shouldHaveParseError (Right _) _ = True `shouldBe` False
shouldHaveParseError (Left e) err = show e `shouldBe` intercalate "\n" err


spec :: Spec
spec =
  describe "parseConnectionString" $ do
    it "should parse a valid connection string" $
      parseConnectionString connectionString `shouldBe` Right ["user", "password", "domain", "port", "dbname"]

    it "should return an error when passed an invalid connection string" $ do
      parseConnectionString "foo" `shouldHaveParseError` ["(line 1, column 1):",
                                                          "unexpected \"f\"",
                                                          "expecting \"mongodb://\""]

      parseConnectionString "mongodb://foo@bar" `shouldHaveParseError` ["(line 1, column 14):",
                                                                        "unexpected \"@\"",
                                                                        "expecting letter or \":\""]
