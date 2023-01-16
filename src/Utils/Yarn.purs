module Cli.Utils.Yarn
  ( build
  )
  where

import Effect.Aff (Aff)
import Cli.Utils.Spawn (CWD, Options, SpawnResult, spawn)

yarn :: Options -> CWD -> Aff SpawnResult
yarn = spawn "yarn"

build :: CWD -> Aff SpawnResult
build cwd = yarn ["build"] cwd