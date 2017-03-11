module Src.Update exposing (update)

import Src.Action exposing (..)
import Src.Model exposing (Model)

update : Action -> Model -> (Model, Cmd Action)
update action mdl =
    case action of
        Test ->
            { mdl | t = mdl.t + 0.1 } ! []
            
        Tick d ->
            { mdl | t = mdl.t + d / 1000 } ! []
        
        NoOp -> mdl ! []