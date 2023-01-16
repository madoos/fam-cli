module Cli.Argv.Parser
  ( cli
  , createCommand
  , firstArgument
  , handleAffA1_
  )
  where

import Prelude

import Data.Array (fold)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Options.Applicative (CommandFields, Mod, Parser, argument, command, execParser, header, helper, idm, info, progDesc, str, subparser, (<**>))

firstArgument :: Parser String
firstArgument = argument str idm

createCommand :: ∀ a. String -> String -> (a -> Effect Unit) -> Parser a -> Mod CommandFields (Effect Unit)
createCommand name description hanlder parser = command name $ infoParser description'
  where 
    description' = progDesc description
    infoParser = info $ (hanlder <$> parser) <**> helper

cli :: ∀ a. { name:: String, description:: String, commands:: Array (Mod CommandFields (Effect a)) } -> Effect a
cli options = join $ execParser $ info commandsWithHelp $ cliName <> cliDescription 
  where
    cliName = header options.name
    cliDescription = progDesc options.description
    commands' = subparser $ fold options.commands
    commandsWithHelp = commands' <**> helper

handleAffA1_ :: ∀ a. (a -> Aff Unit) -> (a -> Effect Unit) 
handleAffA1_ f = f >>> launchAff_