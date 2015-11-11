module Main where

import Html exposing (..)
import Html.Attributes exposing (src)
import Keyboard exposing (..)
import Set exposing (isEmpty)

isAnyKeyDown : Signal Bool
isAnyKeyDown = 
  Signal.map (\keys -> not (Set.isEmpty keys)) Keyboard.keysDown 

port playAudio : Signal ()
port playAudio =
  Signal.map (\_ -> ()) isAnyKeyDown

view : Bool -> Html
view isAnyKeyDown =
  if | isAnyKeyDown -> img [ src "note.png" ] [] 
     | otherwise -> div [] [] 

main : Signal Html
main =
  Signal.map view isAnyKeyDown
