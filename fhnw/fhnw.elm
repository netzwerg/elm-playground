module Main where

import Html exposing (..) 
import Html.Attributes exposing (src, style)
import Keyboard exposing (..)
import Set exposing (..)
import Signal exposing (..)

-- MODEL

type alias Model = Bool

initialModel : Model
initialModel = False

-- UPDATE

update : Set KeyCode -> Model -> Model
update keysDown model =
  not (Set.isEmpty keysDown)    

model : Signal Model
model =
  Signal.foldp update initialModel Keyboard.keysDown 

-- PORTS

port playAudio : Signal () 
port playAudio =
    Signal.map (\_ -> ()) model 

-- VIEW

view : Model -> Html
view isAnyKeyDown =
  div [backgroundCss isAnyKeyDown] [ logo ] 

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

main : Signal Html
main =
  Signal.map view model
