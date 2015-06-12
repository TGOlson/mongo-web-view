module Services.Parser where


import Text.Parsec


prefix :: Parsec String () String
prefix = string "mongodb://"


letters :: Parsec String () String
letters = many1 letter


parseHost :: Parsec String () String
parseHost = do
  domain <- letters
  port   <- char ':' >> letters

  return (domain ++ ":" ++ port)


parser :: Parsec String () [String]
parser = do
  user     <- prefix   >> letters
  password <- char ':' >> letters
  host     <- char '@' >> parseHost
  dbname   <- char '/' >> letters

  return [user, password, host, dbname]


-- Parse connection string
-- "mongodb://user:password@domain:port/dbname"
-- ["user", "password", "domain:port", "dbname"]
parseConnectionString :: String -> Either ParseError [String]
parseConnectionString = parse parser ""
