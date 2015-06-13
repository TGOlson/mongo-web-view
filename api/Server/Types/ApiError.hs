{-# LANGUAGE OverloadedStrings #-}

module Types.ApiError where


import Data.Aeson


data ApiError = ApiError String deriving (Eq)


instance Show ApiError where
  show (ApiError err) = err


instance ToJSON ApiError where
  toJSON (ApiError err) = object ["error" .= err]


convertErrorType :: Show a => Either a b -> Either ApiError b
convertErrorType (Left err) = Left . ApiError $ show err
convertErrorType (Right x) = Right x
