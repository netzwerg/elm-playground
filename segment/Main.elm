import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Color exposing (..)
import List exposing (..)
import Mouse exposing (position, clicks)

-- CONFIG

size = 300

-- MODEL

type alias Model = List (Float, Float)

-- VIEW

view : Model -> Element
view model =
  collage size size (content model)

content : Model -> List Form
content points =
  List.map toSquare points

toSquare : (Float, Float) -> Form
toSquare (x, y) =
  square 10
    |> filled blue
    |> move (x, y)

-- SIGNALS

clickPosition : Signal (Float, Float)
clickPosition =
  Signal.map toViewCoordinates (Signal.sampleOn Mouse.clicks Mouse.position)

toViewCoordinates : (Int, Int) -> (Float, Float)
toViewCoordinates (x, y) =
  let halfSize = size / 2
  in
    (toFloat x - halfSize, halfSize - toFloat y)

model : Signal Model
model =
  Signal.foldp (::) [] clickPosition

-- MAIN

main : Signal Element
main =
  Signal.map view model