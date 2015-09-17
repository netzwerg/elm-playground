import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Time exposing (..)
import Window
import List exposing (..)
import AnimationFrame

-- MODEL

size = 600
circleSize = 240
dotCount = 12
dotSize = 10
velocity = 0.01

type alias Dot =
    { index : Int
    , x : Float
    , y : Float
    }

defaultDot : Dot
defaultDot =
    { index = 0
    , x = 0.0
    , y = 0.0
    }

type alias State = { dots : List Dot }

defaultState : State
defaultState = { dots = map (\i -> { defaultDot | index <- i}) [ 0 .. dotCount - 1 ] }

-- UPDATE

update : Time -> State -> State
update time state = { state | dots <- map (moveDot time) state.dots }

moveDot : Time -> Dot -> Dot
moveDot time dot =
  let s = velocity * time / pi
      offset = toFloat dot.index * pi / toFloat dotCount
      newX = (-circleSize + dotSize) * cos(s + offset)
  in { dot | x <- newX }

-- VIEW

view : State -> Element
view state =
   let background = filled black (circle circleSize)
       dotLinePairs = map viewDotWithLine state.dots
   in collage size size (background :: dotLinePairs)

viewDot : Dot -> Form
viewDot d = alpha 0.8 (filled lightOrange (circle dotSize)) |> move (d.x, d.y)

viewDotWithLine : Dot -> Form
viewDotWithLine dot =
  let dotView = viewDot dot
      lineView = traced (solid white) (path [ (-size / 2.0, 0) , (size / 2.0, 0) ])
      dotAndLineView = group [dotView , lineView]
  in dotAndLineView |> rotate (toFloat dot.index * (pi / dotCount))

-- SIGNALS

main = Signal.map view animate

animate : Signal State
animate = Signal.foldp update defaultState time

time = Signal.foldp (+) 0 AnimationFrame.frame