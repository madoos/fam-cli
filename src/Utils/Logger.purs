module Cli.Utils.Logger
  ( error
  , warning
  )
  where

import Ansi.Codes (Color(..))
import Ansi.Output (withGraphics, bold, foreground)
import Effect (Effect)
import Effect.Class.Console as Console
import Prelude (Unit, (<>), (>>>))

createLogger :: Color -> (String -> Effect Unit)
createLogger color = withGraphics (bold <> foreground color) >>> Console.log

warning ∷ String → Effect Unit
warning = createLogger Yellow

error ∷ String → Effect Unit
error = createLogger Red