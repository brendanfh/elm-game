module Src.Model
    exposing
        ( Model
        , Positioned
        , Sized
        , Moving
        , Rectangle
        , GameObject
        , Player
        , KeyState
        , initialModel
        )

import Math.Vector2 exposing (vec2, Vec2)


type alias Model =
    { player : Player
    , keyState : KeyState
    }


type alias Positioned a =
    { a | position : Vec2 }


type alias Sized a =
    { a | size : Vec2 }


type alias Moving a =
    { a | velocity : Vec2 }


type alias Rectangle a =
    Sized (Positioned a)


type alias GameObject a =
    Moving (Rectangle a)


type alias Player =
    GameObject
        { score : Int
        }


type alias KeyState =
    { up : Bool
    , down : Bool
    , left : Bool
    , right : Bool
    }


initialPlayer =
    { position = vec2 0 0
    , size = vec2 50 50
    , velocity = vec2 0 0
    , score = 0
    }


initialKeyState =
    { up = False
    , down = False
    , left = False
    , right = False
    }


initialModel : Model
initialModel =
    { player = initialPlayer
    , keyState = initialKeyState
    }
