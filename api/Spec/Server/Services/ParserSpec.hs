{-# LANGUAGE OverloadedStrings   #-}

module Server.Services.ParserSpec where


import Test.Hspec
import Services.Parser
import Data.List


main :: IO ()
main = hspec spec


shouldHaveParseError :: Show a => Either a b -> [String] -> Expectation
shouldHaveParseError (Right _) _ = True `shouldBe` False
shouldHaveParseError (Left e) err = show e `shouldBe` intercalate "\n" err


spec :: Spec
spec =
  describe "parseConnectionString" $ do
    it "should parse a valid connection string" $
      parseMongoUriParts "mongodb://user-name:password@d0.domain.com:123/db_name"
        `shouldBe` Right ("user-name", "password", "d0.domain.com", 123, "db_name")

    it "should return an error when passed an invalid connection string" $ do
      parseMongoUriParts "foo" `shouldHaveParseError`
        ["(line 1, column 1):", "unexpected \"f\"", "expecting \"mongodb://\""]

      parseMongoUriParts "mongodb://foo@bar" `shouldHaveParseError`
        ["(line 1, column 14):", "unexpected \"@\"", "expecting letter, \"-\", \"_\" or \":\""]
