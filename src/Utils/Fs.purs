module Cli.Utils.Fs
  ( modify
  )
  where

import Effect.Aff (Aff)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (readTextFile, writeTextFile)
import Node.Path (FilePath)
import Prelude (Unit, bind)

modify :: (String -> String) -> FilePath -> Aff Unit
modify transform path = do 
  content <- readTextFile UTF8 path
  let content' = transform content
  writeTextFile UTF8 path content'