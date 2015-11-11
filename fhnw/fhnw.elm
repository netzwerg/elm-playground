module Main where

import Html exposing (..) 
import Html.Attributes exposing (src, style)
import Keyboard exposing (..)
import Set exposing (..)
import Signal exposing (..)

-- SIGNALS & PORTS

isAnyKeyDown : Signal Bool
isAnyKeyDown = 
  Signal.map (\keys -> not (Set.isEmpty keys)) Keyboard.keysDown 

port playAudio : Signal ()
port playAudio =
  Signal.map (\_ -> ()) isAnyKeyDown

-- VIEW

view : Bool -> Html
view isAnyKeyDown =
  div [ backgroundCss isAnyKeyDown ] [ logo ] 

backgroundCss : Bool -> Attribute
backgroundCss isAnyKeyDown =
  let background = if | isAnyKeyDown -> "#ffff00"
                      | otherwise -> "#cccccc"
  in style
      [ ("width", "100%")
      , ("height", "100%")
      , ("position","absolute") 
      , ("top", "0")
      , ("left", "0")
      , ("background", background)
      ]

logo : Html
logo =
  img [ src "fhnw.png" , logoCss ] [] 

logoCss : Attribute
logoCss =
  style 
    [ ("width", "50%")
    , ("position", "absolute")
    , ("top", "0")
    , ("left", "0")
    , ("right", "0")
    , ("bottom", "0")
    , ("margin", "auto")
    ]

-- MAIN

main : Signal Html
main =
  Signal.map view isAnyKeyDown 
