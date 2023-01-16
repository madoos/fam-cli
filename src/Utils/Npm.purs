module Cli.Utils.Npm 
(
  npm
  ,bump
)

where

import Effect.Aff (Aff)
import Cli.Utils.Spawn (CWD, Options, SpawnResult, spawn)

type Version = String

npm :: Options -> CWD -> Aff SpawnResult
npm = spawn "npm"

bump :: Version -> CWD -> Aff SpawnResult
bump version cwd = npm ["version", version, "--no-git-tag-version"] cwd
