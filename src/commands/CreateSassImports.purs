module Cli.Commands.CreateSassImports
  ( createSassImportCommand )
  where

import Prelude
import Data.Array (concat, filter, foldMap)
import Data.String.Utils (endsWith)
import Data.Traversable (traverse)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (readdir, stat, writeTextFile)
import Node.FS.Stats (isDirectory)
import Cli.Utils.Fs (readDirDeep)


createScssImpor :: String -> String 
createScssImpor path = "@import " <> "\"" <> path <> "\"" <> ";"

toScssImports :: Array String -> String
toScssImports = filter (endsWith ".scss") >>> map createScssImpor >>> foldMap (_ <> "\n")

createSassImport :: String -> String -> Aff Unit
createSassImport destination origin = do
  files <- readDirDeep origin
  let scss = toScssImports files
  writeTextFile UTF8 destination scss

createSassImportCommand :: String -> String -> Effect Unit
createSassImportCommand destination origin = launchAff_ $ createSassImport destination origin