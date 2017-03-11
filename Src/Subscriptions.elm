module Src.Subscriptions exposing (subscriptions)

import Src.Action exposing (..)
import Src.Model exposing (Model)
import AnimationFrame
import Mouse
import Keyboard


subscriptions : Model -> Sub Action
subscriptions mdl =
    Sub.batch
        [ AnimationFrame.diffs (\t -> Tick (t / 1000))
        , Keyboard.downs (KeyChange True)
        , Keyboard.ups (KeyChange False)
        ]
