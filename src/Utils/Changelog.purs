module Cli.Utils.Changelog
  ( changelog
  , getCliPath
  )
  where

import Prelude

import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Node.Path (FilePath, concat)
import Cli.Utils.Globals (dirname)
import Cli.Utils.Spawn (CWD, SpawnResult, spawn)

getCliPath :: Aff FilePath
getCliPath = liftEffect $ (\__dirname -> concat [__dirname, "../node_modules/.bin/conventional-changelog"]) <$> dirname

changelog :: CWD -> Aff SpawnResult
changelog cwd = do
  cliPath <- getCliPath
  spawn cliPath ["-p", "angular", "-i", "CHANGELOG.md", "-s"] cwd