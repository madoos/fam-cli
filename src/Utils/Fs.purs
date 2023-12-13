module Cli.Utils.Fs
  ( modify
  , readDirDeep
  )
  where

import Effect.Aff (Aff)
import Data.Array (concat, filter, foldMap)
import Data.Traversable (traverse)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (readTextFile, writeTextFile)
import Node.Path (FilePath)
import Node.FS.Aff (readdir, stat, writeTextFile)
import Node.FS.Stats (isDirectory)
import Prelude (Unit, bind, (<>), ($), pure)


modify :: (String -> String) -> FilePath -> Aff Unit
modify transform path = do 
  content <- readTextFile UTF8 path
  let content' = transform content
  writeTextFile UTF8 path content'

readDirDeep :: String -> Aff (Array String)
readDirDeep dir = do
  entries <- readdir dir
  files <- traverse (readDirDeep' dir) entries
  pure $ concat files

readDirDeep' :: String -> String -> Aff (Array String)
readDirDeep' baseDir entry = do
  let fullPath = baseDir <> "/" <> entry
  fileInfo <- stat fullPath
  isDir <- pure $ isDirectory fileInfo
  if isDir
    then readDirDeep fullPath
    else pure [fullPath]