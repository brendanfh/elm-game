module Main exposing (main)

import Src.Action exposing (..)
import Src.Model exposing (..)
import Src.Update exposing (..)
import Src.View exposing (..)
import Src.Subscriptions exposing (..)
import Html


main : Program Never Model Action
main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
