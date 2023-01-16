module Cli.Commands.Release
  ( release
  , releaseCommand
  )
  where

import Prelude

import Cli.Argv.Parser (handleAffA1_)
import Cli.Html.Parser (parseHtml, read, prepend, prettify)
import Cli.Utils.Fs (modify)
import Cli.Utils.Git (createBranch)
import Cli.Utils.Logger (error, warning)
import Cli.Utils.Npm (bump)
import Cli.Utils.Spawn (exitError, exitSuccess)
import Cli.Utils.Spinner (withNotifiedSpinner)
import Cli.Utils.Yarn (build)
import Data.Either (Either(..))
import Data.String.Common (joinWith)
import Data.TemplateString.Unsafe ((<~>))
import Data.Version (parseVersion, showVersion)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Node.Path (FilePath)
import Node.Process (cwd)
import Parsing (ParseError)

validate :: String -> Either ParseError String
validate = parseVersion >>> map showVersion

addReleaseLink :: String -> FilePath -> Aff Unit
addReleaseLink version path = modify addLink path 
  where
  addLink :: String -> String
  addLink = read >>> prepend "ul" link >>> parseHtml >>> prettify
  link = "<li><a href=/${version}/index.html >${version}</a></li>" <~> { version }

release :: String -> Aff Unit
release version = do
  cwd' <- liftEffect cwd
  let publicPath = cwd' <> "/public/index.html"
  _ <- createBranch ("release-" <> version) cwd'
  _ <- build cwd'
  _ <- bump version cwd'
  -- _ <- changelog cwd'
  addReleaseLink version publicPath

showValidarionError :: String -> Effect Unit
showValidarionError version = error $ joinWith " " [version, "is an invalid version."]

releaseCommand :: String -> Effect Unit
releaseCommand version =
  case validate version of 
    Right version' -> do
      release' version'
    Left _ -> do
      showValidarionError version
      exitError
  where
    release' =  handleAffA1_ $ release >>> withNotifiedSpinner "Creating Rocket Release." (liftEffect exitAndNotify) 
    exitAndNotify = do 
      warning changelogMessage
      warning commitMessage
      exitSuccess  
    changelogMessage = "1. The changelog has not been generated because a standard commit convention is not used. Update it manually."
    commitMessage = "2. Remember to check changes and do: " <> ("git commit -m 'Bumped version to ${version}'" <~> { version })