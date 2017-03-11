module Src.Action exposing (Action(..))

import Keyboard exposing (KeyCode)


type Action
    = NoOp
    | KeyChange Bool KeyCode
    | Tick Float
