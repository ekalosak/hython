module Main where

import Lib

main :: IO ()
main = do
  putStrLn "\n"
  putStrLn "*** BEGIN: Running a few python bind strategies:"
  putStrLn "--- Piping json printed from a python program to a haskell type ---"
  runHello
  putStrLn "\n"
  putStrLn "--- Getting python version through the C FFI ---"
  printPyVersion
  putStrLn "--- Running python hello world function through the C FFI ---"
  importPyLib
  putStrLn "*** END"
