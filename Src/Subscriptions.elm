module Src.Subscriptions exposing (subscriptions)

import Src.Action exposing (..)
import Src.Model exposing (Model)

import AnimationFrame
import Mouse

subscriptions : Model -> Sub Action
subscriptions mdl =
    Sub.batch
        [ Mouse.clicks (always Test)
        , AnimationFrame.diffs Tick ]