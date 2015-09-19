import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Time exposing (..)
import Window
import List exposing (..)
import AnimationFrame -- "jwmerrill/elm-animation-frame"

-- CONFIG

size = 600
circleSize = 240
dotCount = 12
dotSize = 10
velocity = 0.01

-- MODEL

type alias Dot =
    { x : Float
    , angle : Float
    }

type alias State = { dots : List Dot }

defaultState : State
defaultState = { dots = map createDot [ 0 .. dotCount - 1 ] }

createDot : Int -> Dot
createDot index =
    let angle = toFloat index * pi / dotCount
    in { x = 0
       , angle = angle
       }

-- UPDATE

update : Time -> State -> State
update time state = { state | dots <- map (moveDot time) state.dots }

moveDot : Time -> Dot -> Dot
moveDot time dot =
  let t = velocity * time / pi
      newX = (-circleSize + dotSize) * cos(t + dot.angle)
  in { dot | x <- newX }

-- VIEW

view : State -> Element
view state =
   let background = filled black (circle circleSize)
       dotLinePairs = map viewDotWithLine state.dots
   in collage size size (background :: dotLinePairs)

viewDotWithLine : Dot -> Form
viewDotWithLine dot =
  let dotView = viewDot dot
      lineView = createLineView
  in group [dotView , lineView] |> rotate dot.angle

viewDot : Dot -> Form
viewDot d = alpha 0.8 (filled lightOrange (circle dotSize)) |> move (d.x, 0)

createLineView : Form
createLineView = traced (solid white) (path [ (-size / 2.0, 0) , (size / 2.0, 0) ])

-- SIGNALS

main = Signal.map view animate

animate : Signal State
animate = Signal.foldp update defaultState time

time = Signal.foldp (+) 0 AnimationFrame.frame