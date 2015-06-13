{-# LANGUAGE OverloadedStrings   #-}

module Server.Services.DBSpec where


import Test.Hspec
import Services.DB


main :: IO ()
main = hspec spec


spec :: Spec
spec =
  describe "parseMongoConfig" $
    it "should parse a valid connection string to a mongo config" $ do
      let expectedConfig = MongoConfig {
          username = "user-name",
          password = "password",
          host     = "d0.domain.com:123",
          dbname   =  "db_name"
        }

      parseMongoConfig "mongodb://user-name:password@d0.domain.com:123/db_name"
        `shouldBe` Right expectedConfig
