module Src.Model exposing (Model, initialModel)

type alias Model = 
    { t : Float }
    
initialModel : Model
initialModel = { t = 0 }