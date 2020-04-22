module Main exposing (..)

import Browser
import Element
    exposing
        ( Element
        , alignRight
        , centerX
        , centerY
        , column
        , el
        , fill
        , height
        , padding
        , rgb255
        , row
        , spacing
        , text
        , width
        )
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input


main =
    Element.layout
        [ Background.image "https://images.unsplash.com/photo-1503252947848-7338d3f92f31"
        ]
        cover


cover =
    row [ width fill, height fill, centerY ]
        [ row
            [ centerX
            , Element.alignBottom
            , width
                (fill |> Element.maximum 1000)
            , Background.color (rgb255 60 56 54)
            , height (fill |> Element.maximum 400)
            , Border.rounded 6
            ]
            [ menubar
            ]
        ]


menubar =
    row
        [ Element.alignTop
        , Background.color (rgb255 50 48 47)
        , width fill
        , Border.roundEach
            { bottomLeft = 0
            , bottomRight = 0
            , topLeft = 6
            , topRight = 6
            }
        , spacing 10
        ]
        [ portaButton "Inicio"
        , portaButton "Proyectos"
        , portaButton "Acerca de..."
        ]


portaButton : String -> Element Order
portaButton txt =
    Input.button
        [ Background.color (rgb255 40 40 40)
        , Font.color (rgb255 146 131 116)
        , padding 10
        , centerX
        , Border.widthEach
            { bottom = 3
            , left = 0
            , right = 0
            , top = 3
            }
        , Border.color (rgb255 146 131 116)
        , Element.mouseOver
            [ Background.color (rgb255 146 131 116)
            , Font.color (rgb255 0 0 0)
            , Border.color (rgb255 0 0 0)
            ]
        ]
        { onPress = Nothing, label = text txt }
