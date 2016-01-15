import String exposing (toList, fromChar)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Text exposing (..)
import Window
import Color
import Debug

view : (Int, Int) -> String -> Element
view (width, height) input =
    collage width height (charsToForms (String.toList input))


charsToForms : List Char -> List Form
charsToForms chars =
    let
        elements = List.map charToElement chars
        elementWidths = List.map widthOf elements
        offsets = List.scanl (+) 0 elementWidths 
        elementsWithOffsets = List.map2 (,) elements offsets
    in 
        elementsToForm elementsWithOffsets 


charToElement : Char -> Element
charToElement c =
    let
        text = fromString (fromChar c) 
            |> typeface ["serif"]
            |> Text.height 99
            |> Text.color Color.white
    in 
        leftAligned text


elementsToForm : List (Element, Int) -> List Form
elementsToForm elementsWithOffsets =
    List.map elementToForm elementsWithOffsets 


elementToForm : (Element, Int) -> Form
elementToForm (element, offset) =
    let
        distinctColor = Color.rgba offset 10 offset 0.7 
        coloredElement = element |> Graphics.Element.color distinctColor 
    in
        toForm coloredElement
            |> moveX (toFloat offset)
            |> moveX (toFloat (widthOf element) / 2.0)


main : Signal Element
main =
    Signal.map (flip view "Hello") Window.dimensions
