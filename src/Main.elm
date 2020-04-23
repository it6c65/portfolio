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
        , image
        , padding
        , rgb255
        , rgba255
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
    column [ width fill, height fill, centerY ]
        [ profile, actualContent ]


profile =
    row
        [ centerX
        , Element.alignTop
        , width (fill |> Element.maximum 800)
        , Background.color (rgba255 40 40 40 0.4)
        , height (fill |> Element.maximum 375)
        , Border.rounded 6
        , Element.spacingXY 0 20
        ]
        [ -- HardCoded Spacing xD
          el [] (text "     ")

        -- Image's Profile
        , el []
            (image
                [ Border.rounded 500
                , Element.clip
                , width <| Element.px 300
                , height <| Element.px 300
                , Border.color (rgb255 146 131 116)
                , Border.width 6
                ]
                { src = "https://avatars0.githubusercontent.com/u/45639906"
                , description = "Photo_Me"
                }
            )

        -- Letters & title
        , column
            [ centerX --, Element.alignTop, Element.paddingXY 0 40
            , Font.family
                [ Font.external
                    { url = "https://fonts.googleapis.com/css2?family=IBM+Plex+Serif:ital,wght@0,500;1,500"
                    , name = "IBM Plex Serif"
                    }
                ]
            ]
            [ el
                [ Font.family
                    [ Font.external
                        { url = "https://fonts.googleapis.com/css2?family=Pacifico"
                        , name = "Pacifico"
                        }
                    ]
                , Font.size 62
                , Font.color (rgb255 146 131 116)
                ]
                (text "Luis Ilarraza")
            , el
                [ Font.color (rgb255 107 70 76)
                , Element.paddingXY 0 20
                , Font.size 32
                ]
                (text "Technician & Programmer")
            ]
        ]


actualContent =
    column
        [ centerX
        , Element.alignBottom
        , width
            (fill |> Element.maximum 1000)
        , Background.color (rgb255 60 56 54)
        , height (fill |> Element.maximum 400)
        , Border.rounded 6
        ]
        [ menubar ]


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
            , Font.color (rgb255 40 40 40)
            , Border.color (rgb255 40 40 40)
            ]
        ]
        { onPress = Nothing, label = text txt }
