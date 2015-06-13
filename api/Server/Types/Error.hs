module Types.Error where


data Error = Error String deriving (Eq)


instance Show Error where
  show (Error err) = err


convertErrorType :: Show a => Either a b -> Either Error b
convertErrorType (Left err) = Left . Error $ show err
convertErrorType (Right x) = Right x
