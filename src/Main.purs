module Main where

import Effect (Effect)
import Prelude (Unit)
import Cli.Argv.Parser (cli, createCommand, firstArgument)
import Cli.Commands.Release (releaseCommand)
import Cli.Commands.CreateSassImports (createSassImportCommand)

main :: Effect Unit
main = cli { 
  name: "fam",
  description: "Automatize Family team process.",
  commands: [
    createCommand "release" "Create rocker release" releaseCommand firstArgument,
    createCommand "imports" "Create sass imports" (createSassImportCommand "imports.scss") firstArgument
  ]
}
