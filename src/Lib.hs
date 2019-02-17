{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( runHello
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

toWord = BS.head . CH.pack
newline = toWord "\n"
teststring = CH.pack "\nhello\nworld\n"
stripNewline = BS.filter (/= newline)

pythonSrc :: FilePath
pythonSrc = "./src/hello.py"

yieldEncode = yield . BL.toStrict . encode

extractMyType = do
  Just x <- await
  let y = stripNewline x
  let mz = decodeStrict y :: Maybe MyType
  maybe (yield BS.empty) yieldEncode mz

runHello = run (
  python pythonSrc $|
  conduit extractMyType
  )

data MyType = MyType {foo :: Int} deriving (Show, Generic)
instance FromJSON MyType
instance ToJSON MyType
