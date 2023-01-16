module Cli.Utils.Spawn
  ( 
   CWD
  ,Options
  , SpawnResult
  , exitError
  , exitSuccess
  , spawn
  )
  where

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Aff)
import Node.ChildProcess as CP
import Node.Process (exit)
import Prelude (Unit)
import Sunde as S

type CWD = String
type Options = Array String
type SpawnResult = { exit :: CP.Exit, stderr :: String, stdout :: String }

spawn :: String -> Options -> CWD -> Aff SpawnResult
spawn cmd args cwd = S.spawn { cmd, args, stdin: Nothing } { cwd: (Just cwd) , detached: false , env: Nothing , gid: Nothing , stdio: [(Just CP.Pipe)] , uid: Nothing }

exitError :: Effect Unit
exitError = exit 1

exitSuccess :: Effect Unit
exitSuccess = exit 0
