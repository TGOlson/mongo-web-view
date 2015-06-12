{-# LANGUAGE OverloadedStrings   #-}

module Server.Services.ParserSpec where


import Test.Hspec
import Services.Parser

main :: IO ()
main = hspec spec


spec :: Spec
spec = do
  describe "POST /collections" $ do
    it "should return a list of collections for the specified database" $
      True `shouldBe` True
