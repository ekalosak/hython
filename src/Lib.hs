{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( printPyVersion, importPyLib, runHello, teststring, stripNewline, newline
    ) where

import qualified Control.Exception as E
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as CH
import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString.Lazy.Char8 as CHL
import Data.Aeson
import Data.Conduit
import Data.Conduit.Shell
import Data.Maybe
import GHC.Generics
import qualified CPython as Py
import qualified CPython.Protocols.Object as Py
import qualified CPython.Types.Exception as Py
import qualified CPython.Types as Py
import qualified CPython.Types.Module as Py
import System.IO (stdout)
import System.Directory
import System.FilePath
import System.Environment (getEnvironment)
import System.Posix.Env (putEnv)

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

runHello :: IO ()
runHello = do
  run (
    python pythonSrc $|
    conduit extractMyType
    )

printPyVersion :: IO ()
printPyVersion = do
  Py.initialize
  ver <- Py.getVersion
  print ver

setPythonPath :: IO ()
setPythonPath = do
  curpath <- getCurrentDirectory
  let pythonpath = curpath </> "src"
  let pathSet = "PYTHONPATH=" <> pythonpath
  -- print pathSet
  -- setEnv "PYTHONPATH" pythonpath
  -- putEnv pathSet
  run ( do
    echo pathSet
    shell $ "export " <> pathSet
    )

importPyLib :: IO ()
importPyLib = do
  -- setPythonPath -- NOTE: this doesn't actually export the envVar... weird
  Py.initialize
  -- e <- getEnvironment
  -- print e
  E.handle onException $ do
    -- syst <- Py.importModule "sys"
    -- syst_path <- Py.getAttribute syst =<< Py.toUnicode "path"
    -- Py.print syst_path stdout

    hello <- Py.importModule "hello"
    hello_world <- Py.getAttribute hello =<< Py.toUnicode "hello_world"
    res <- Py.callArgs hello_world []
    Py.print res stdout

onException :: Py.Exception -> IO ()
onException exc = Py.print (Py.exceptionValue exc) stdout

data MyType = MyType {foo :: Int} deriving (Show, Generic)
instance FromJSON MyType
instance ToJSON MyType
