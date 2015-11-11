module Main where

import Html exposing (..)
import Html.Attributes exposing (src)
import Keyboard exposing (..)
import Set exposing (isEmpty)

isAnyKeyDown : Signal Bool
isAnyKeyDown = 
  Signal.map (\keys -> not (Set.isEmpty keys)) Keyboard.keysDown 

isAnyKeyPressed : Signal Bool
isAnyKeyPressed =
  Signal.filter identity False isAnyKeyDown

port playAudio : Signal ()
port playAudio =
  Signal.map (\_ -> ()) isAnyKeyPressed 

view : Bool -> Html
view isAnyKeyDown =
  if | isAnyKeyDown -> img [ src "note.png" ] [] 
     | otherwise -> div [] [] 

main : Signal Html
main =
  Signal.map view isAnyKeyDown
