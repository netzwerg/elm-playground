module Logopedia where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Random exposing (..)
import Array exposing (..)
import Debug

-- CONFIG

words = fromList [
    "Kühlschrank",
    "Stiefel",
    "Waschbecken",
    "Lippenstift",
    "Vogelscheuche",
    "Bohrmaschine",
    "Meerschweinchen",
    "Taschenlampe",
    "Rollschuhe",
    "Geschenk",
    "Dusche",
    "Waschmaschine",
    "Kirsche",
    "Schleckstengel",
    "Geschirrwaschmaschine",
    "Wildschwein",
    "Shakira",
    "Flasche",
    "Umschlag",
    "Rutschbahn",
    "Hubschrauber",
    "Muschel",
    "Fallschirm",
    "Frösche",
    "Regenschirm",
    "Tasche",
    "Kutsche",
    "Besteck"
    ]

-- MODEL

type alias Model = 
    { word : String
    , seed : Seed
    }

-- UPDATE

type Action = ShowRandomWord

update : Action -> Model -> Model
update action model =
    case action of
        ShowRandomWord -> randomWord model |> Debug.watch "Model"

randomWord : Model -> Model
randomWord model =
    let (randomIndex, seed') =
            generate (int 0 (length words - 1)) model.seed
        randomWord = Array.get randomIndex words
        randomWord' = Maybe.withDefault "" randomWord
    in { word = randomWord' , seed = seed' }

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
    div [css]
        [ h1 [] [ text model.word ]
        , button [ onClick address ShowRandomWord ] [ text "Next" ]
        ]

css : Attribute
css =
    style
        [ ("width", "500px")
        , ("margin", "0 auto")
        ]
