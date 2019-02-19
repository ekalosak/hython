module Main where

import Lib

main :: IO ()
main = do
  putStrLn "\n"
  putStrLn "*** BEGIN: Running a few python bind strategies:"
  putStrLn "--- Piping json printed from a python program to a haskell type ---"
  runHello
  putStrLn "\n"
  putStrLn "--- Running python functions through the C FFI ---"
  printPyVersion
  putStrLn "*** END"
