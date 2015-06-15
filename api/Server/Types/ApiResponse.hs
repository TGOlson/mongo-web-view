module Types.ApiResponse where


import Data.Aeson
import Types.ApiError


data ApiResponse a = ApiResponse (Either ApiError a)


instance (ToJSON a) => ToJSON (ApiResponse a) where
  toJSON (ApiResponse (Left e))  = toJSON e
  toJSON (ApiResponse (Right x)) = toJSON x
