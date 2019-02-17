{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( someFunc, pythonSrc, runHello, MyType
    ) where

import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as CH
import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString.Lazy.Char8 as CHL
import Data.Aeson
import Data.Conduit
import Data.Conduit.Shell
import Data.Maybe
import GHC.Generics

import Debug.Trace

debug = traceM . show
toWord = BS.head . CH.pack
newline = toWord "\n"
teststring = CH.pack "\nhello\nworld\n"
stripNewline = BS.filter (/= newline)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

pythonSrc :: FilePath
pythonSrc = "./src/hello.py"

mine = MyType 2

extractMyType = do
  mx <- await
  let x = fromMaybe BS.empty mx
  -- let y = stripNewline x
  debug x
  -- debug y
  yield x

runHello = run (
  python pythonSrc $|
  conduit extractMyType
  )

data MyType = MyType {foo :: Int} deriving (Show, Generic)
instance FromJSON MyType
instance ToJSON MyType
