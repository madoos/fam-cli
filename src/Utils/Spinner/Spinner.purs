module Cli.Utils.Spinner
  ( withNotifiedSpinner
  , withSpinner
  )
  where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
foreign import data Spinner :: Type

foreign import createSpinner :: String -> Spinner

foreign import start :: Spinner -> Effect Spinner

foreign import stop :: Spinner -> Effect Spinner

withSpinner :: String -> Aff Unit -> Aff Unit
withSpinner msg effect = do
  spinner <- liftEffect $ start $ createSpinner msg
  _ <- effect
  _ <- liftEffect $ stop spinner
  pure unit

withNotifiedSpinner :: String -> Aff Unit -> Aff Unit -> Aff Unit
withNotifiedSpinner msg notificationEffect effect = do
  spinner <- liftEffect $ start $ createSpinner msg
  _ <- effect
  _ <- liftEffect $ stop spinner
  notificationEffect
