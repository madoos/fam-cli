module Cli.Html.Parser 
  (
    HtmlParser
    ,read
    ,parseHtml
    ,prepend
    ,prettify
  )
where

foreign import data HtmlParser :: Type

foreign import read :: String -> HtmlParser

foreign import parseHtml :: HtmlParser -> String

foreign import prepend :: String -> String -> HtmlParser -> HtmlParser

foreign import prettify :: String -> String


