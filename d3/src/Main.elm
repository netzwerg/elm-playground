module Main where

import Graphics.Input exposing (..)
import Graphics.Element exposing (..)
import Mouse

import D3 exposing (..)
import D3.Event exposing (..)
import D3.Color

type alias Model = String

events : D3.Event.Stream String
events = stream ()

view : D3 Model String
view =
  static "svg"
  |. selectAll "text"
    |= (\_ -> ["H","E","L","L","O", "!"])
     |- enter <.> append "text"
       |. str style "font-size" "x-large"
       |. str attr "text-anchor" "middle"
       |. fun attr "class" (\_ i -> toString i)
       |. fun attr "dx" (\_ i -> toString (i + 1) ++ "em")
       |. text (\s i -> s)
       |. str attr "transform" (translate 0 0)
         |. transition
         |. duration (\s i -> 3000)
         |. str attr "transform" (translate 0 100)
     |- exit
       |. remove

translate : Int -> Int -> String
translate x y = "translate(" ++ (toString x) ++ "," ++ (toString y) ++ ")"

animate : String -> Model -> Model
animate id model = id

controller : Signal Model
controller =
  let initial = "" in
  D3.Event.folde animate initial events

main : Signal Element
main = Signal.map (render 900 200 view) controller
