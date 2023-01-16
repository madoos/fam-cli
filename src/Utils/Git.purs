module Cli.Utils.Git
  ( git,
    createBranch
  )
  where

import Effect.Aff (Aff)
import Cli.Utils.Spawn (CWD, Options, SpawnResult, spawn)


git :: Options -> CWD -> Aff SpawnResult
git = spawn "git"

createBranch :: String -> CWD -> Aff SpawnResult
createBranch name cwd = git ["checkout", "-b", name] cwd