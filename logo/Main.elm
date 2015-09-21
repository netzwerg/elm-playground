import Logopedia exposing (update, view)
import StartApp.Simple exposing (start)
import Random exposing (initialSeed)

defaultModel =
    { word = "" 
    , seed = initialSeed 99 
    }

main =
  start
    { model = defaultModel 
    , update = update
    , view = view
    }
