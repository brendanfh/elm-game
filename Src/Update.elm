module Src.Update exposing (update)

import Src.Action exposing (..)
import Src.Model exposing (Model, Player, GameObject, KeyState)
import Keyboard exposing (KeyCode)
import Math.Vector2 as Vec2 exposing (vec2, Vec2)


update : Action -> Model -> ( Model, Cmd Action )
update action mdl =
    case action of
        KeyChange down code ->
            ( { mdl
                | keyState = handleKeyChange down code mdl.keyState
              }
            , Cmd.none
            )

        Tick d ->
            ( { mdl
                | player = updatePlayer d mdl.keyState mdl.player
              }
            , Cmd.none
            )

        NoOp ->
            mdl ! []


updatePlayer : Float -> KeyState -> Player -> Player
updatePlayer time keys player =
    player
        |> updatePlayerDirection keys
        |> moveObject time


updatePlayerDirection : KeyState -> Player -> Player
updatePlayerDirection keys player =
    let
        speed =
            100

        yvel =
            if keys.up == keys.down then
                0
            else if keys.up then
                -speed
            else
                speed

        xvel =
            if keys.left == keys.right then
                0
            else if keys.left then
                -speed
            else
                speed
    in
        { player | velocity = vec2 xvel yvel }


moveObject : Float -> GameObject a -> GameObject a
moveObject time object =
    { object
        | position = Vec2.add object.position (Vec2.scale time object.velocity)
    }


handleKeyChange : Bool -> KeyCode -> KeyState -> KeyState
handleKeyChange down code keyState =
    case code of
        87 ->
            { keyState | up = down }

        83 ->
            { keyState | down = down }

        65 ->
            { keyState | left = down }

        68 ->
            { keyState | right = down }

        _ ->
            keyState
