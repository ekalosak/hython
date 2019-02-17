import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)

import qualified Lib as L
import qualified Data.ByteString.Char8 as CH
import qualified Data.ByteString as BS

newlineBS = CH.pack "\n"

main :: IO ()
main = hspec $ do
  describe "hython.basic" $ do
    it "strips the newline character from \"\\nhello\\nworld\\n\"" $ do
      L.stripNewline L.teststring `shouldBe` (CH.pack "helloworld")

    it "strips the newline character from arbitrary bytestrings" $
      property $ \st -> not $ newlineBS `BS.isInfixOf` (L.stripNewline . CH.pack $ st)
