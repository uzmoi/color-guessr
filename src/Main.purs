module Main where

import Prelude

import Effect (Effect)
import Halogen.Aff as HA
import Effect.Aff (Aff)
import Web.DOM.ParentNode (QuerySelector(..))
import Web.HTML.HTMLElement (HTMLElement)
import Effect.Exception (error)
import Data.Maybe (maybe)
import Control.Monad.Error.Class (throwError)
import Halogen.VDom.Driver (runUI)
import App (appRoot)

awaitSelect :: QuerySelector -> Aff HTMLElement
awaitSelect querySelector@(QuerySelector str) = do
  HA.awaitLoad
  element <- HA.selectElement $ querySelector
  maybe (throwError $ error $ "Could not find '" <> str <> "'") pure element

main :: Effect Unit
main = do
  HA.runHalogenAff do
    appEl <- awaitSelect $ QuerySelector "#app"
    runUI appRoot unit appEl
