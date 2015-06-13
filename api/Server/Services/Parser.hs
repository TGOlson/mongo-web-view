module Services.Parser where


import Text.Parsec
import Control.Applicative ((<$>))
import Types.ApiError


type MongoUriParts = (String, String, String, Int, String)


prefix :: Parsec String () String
prefix = string "mongodb://"


uriChar :: Parsec String () Char
uriChar = letter <|> char '-' <|> char '_'


uriChars :: Parsec String () String
uriChars = many1 uriChar


domainId :: Parsec String () String
domainId = many1 (uriChar <|> char '.' <|> digit)


number :: Parsec String () Int
number = read <$> many1 digit


parser :: Parsec String () MongoUriParts
parser = do
  user     <- prefix   >> uriChars
  password <- char ':' >> uriChars
  domain   <- char '@' >> domainId
  port     <- char ':' >> number
  dbname   <- char '/' >> uriChars

  return (user, password, domain, port, dbname)


-- Parse connection string to list of data elements
-- "mongodb://user:password@domain:port/dbname"
-- [user, password, domain, port, dbname]
parseMongoUriParts :: String -> Either ApiError MongoUriParts
parseMongoUriParts = convertErrorType . parse parser ""
