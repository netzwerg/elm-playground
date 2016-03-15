import Graphics.Input exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Text exposing (..)


hover : Signal.Mailbox Bool
hover = Signal.mailbox False


yogi : Element
yogi =
  image 50 50 "http://vignette3.wikia.nocookie.net/parody/images/e/e3/Yogi.jpg"
    |> hoverable (Signal.message hover.address)


view : Bool -> Element
view hovered = flow right [yogi, leftAligned ((fromString (toString hovered)))]


main : Signal Element
main = Signal.map view hover.signal
