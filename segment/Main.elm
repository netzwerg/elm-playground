import Model exposing (model)
import Update exposing (update)
import View exposing (view)
import StartApp.Simple exposing (start)


main =
  start
    { model = model
    , update = update
    , view = view
    }