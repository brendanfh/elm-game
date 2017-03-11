module Src.View exposing (view)

import Src.Action exposing (..)
import Src.Model exposing (Model)

import Html as H exposing (..)
import Html.Attributes exposing (width, height, style)
import Math.Matrix4 as Mat4 exposing (Mat4)
import Math.Vector3 as Vec3 exposing (vec3, Vec3)
import WebGL exposing (Mesh, Shader, Entity)

(=>) : a -> b -> (a, b)
(=>) = (,)

view : Model -> Html Action
view mdl = 
    WebGL.toHtmlWith
        [   WebGL.clearColor 0 0 0 1
        ]
        [   width 800
        ,   height 600
        ,   style [ "display" => "block" ]
        ]
        [ renderQuad (vec3 1 1 1)
            (Mat4.identity
             |> Mat4.translate3 250 250 0
             |> Mat4.scale3 100 100 1)
        ]

renderQuad : Vec3 -> Mat4 -> Entity
renderQuad color objMat =
    WebGL.entity
        vertexShader
        fragmentShader
        quadMesh
        { perspective = perspective
        , object = objMat
        , color = color }
        
perspective : Mat4
perspective =
    Mat4.makeOrtho 0 800 600 0 -1 1
        
type alias Vertex =
    { position : Vec3
    }

quadMesh : Mesh Vertex
quadMesh =
    WebGL.triangles
        [ ( Vertex (vec3 -0.5 -0.5 0)
          , Vertex (vec3  0.5 -0.5 0)
          , Vertex (vec3  0.5  0.5 0)
          )
        , ( Vertex (vec3 -0.5 -0.5 0)
          , Vertex (vec3  0.5  0.5 0)
          , Vertex (vec3 -0.5  0.5 0)
          )
        ]
        
type alias Uniform =
    { perspective : Mat4
    , object : Mat4
    , color : Vec3
    }

vertexShader : Shader Vertex Uniform {}
vertexShader =
    [glsl|
        precision mediump float;

        attribute vec3 position;
        
        uniform mat4 perspective;
        uniform mat4 object;
        
        void main() {
            gl_Position = perspective * object * vec4(position, 1.0);
        }
    |]

fragmentShader : Shader {} Uniform {}
fragmentShader =
    [glsl|
        precision mediump float;
    
        uniform vec3 color;
        
        void main() {
            gl_FragColor = vec4(color, 1.0);
        }
    |]