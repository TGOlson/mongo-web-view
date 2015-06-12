module Services.Parser where


import Text.Parsec


prefix :: Parsec String () String
prefix = string "mongodb://"


letters :: Parsec String () String
letters = many1 letter


parser :: Parsec String () [String]
parser = do
  user     <- prefix   >> letters
  password <- char ':' >> letters
  domain   <- char '@' >> letters
  port     <- char ':' >> letters
  dbname   <- char '/' >> letters

  return [user, password, domain, port, dbname]


-- Parse connection string
-- "mongodb://user:password@domain:port/dbname"
-- ["user", "password", "domain", "port", "dbname"]
parseConnectionString :: String -> Either ParseError [String]
parseConnectionString = parse parser ""
