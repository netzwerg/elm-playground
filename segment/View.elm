module View where

import Model exposing (..)
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import List exposing (..)


view : Model -> Element
view model =
  collage 300 300 (content model)


content : Model -> List Form
content points =
  map toSquare points


toSquare : (Float, Float) -> Form
toSquare (x, y) =
  square 10
    |> filled blue
    |> move (x, y)