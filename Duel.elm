module Duel where

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Mouse
import Window


main : Signal Element
main =
  Signal.map2 scene Mouse.position Window.dimensions


scene : (Int,Int) -> (Int,Int) -> Element
scene (x,y) (w,h) =
  let
    (dx,dy) =
      (toFloat x - toFloat w / 2, toFloat h / 2 - toFloat y)
  in
    collage w h
      [ ngon 3 100
          |> filled blue
          |> rotate (atan2 dy dx)
      , toForm (image 200 200 "img/cat.png") 
          |> move (dx, dy)
      ]
