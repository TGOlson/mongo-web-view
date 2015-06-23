module Utils where


maybeToEither :: a -> Maybe b -> Either a b
maybeToEither x = maybe (Left x) Right
