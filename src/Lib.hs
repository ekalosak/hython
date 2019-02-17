{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( someFunc, pythonSrc, runHello, MyType
    ) where

import qualified Data.ByteString.Lazy as BL
import Data.Aeson
import Data.Conduit
import Data.Conduit.Shell
import GHC.Generics

import Debug.Trace

someFunc :: IO ()
someFunc = putStrLn "someFunc"

pythonSrc :: FilePath
pythonSrc = "./src/hello.py"

myConduit = do
  Just x <- await
  traceM . show $ x
  yield x

runHello = run (
  python pythonSrc $|
  conduit myConduit
  )
-- runHello = run (
--   python pythonSrc $|
-- )

-- decodeConduit :: ConduitT BL.ByteString BL.ByteString IO (Maybe MyType)
-- decodeConduit = 

data MyType = MyType {foo :: Int} deriving (Show, Generic)
instance FromJSON MyType
instance ToJSON MyType

mine = MyType 2
