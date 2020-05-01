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
        , paragraph
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
    Browser.document { init = init, update = update, view = view, subscriptions = subscriptions }


type alias Model =
    { content : Element Msg, active : Bool }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Element.none True, Cmd.none )


type Msg
    = Inicio
    | Proyectos
    | Contacto


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Inicio ->
            ( Model welcome True, Cmd.none )

        Proyectos ->
            ( Model proyectos True, Cmd.none )

        Contacto ->
            ( Model contacto True, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


bgProfileColor =
    rgba255 40 40 40 0.4


primaryBrown =
    rgb255 146 131 116


red =
    rgb255 107 70 76


darkBg =
    rgb255 50 48 47


darkest =
    rgb255 40 40 40


lightBg =
    rgba255 60 56 54 0.9


view : Model -> Browser.Document Msg
view model =
    Browser.Document "Portafolio" <|
        [ Element.layout
            [ Background.image "https://images.unsplash.com/photo-1503252947848-7338d3f92f31"
            ]
            (cover model)
        ]


cover model =
    column [ width fill, height fill, centerY ]
        [ profile, actualContent model ]


profile =
    row
        [ centerX
        , Element.alignTop
        , width (fill |> Element.maximum 800)
        , Background.color <| bgProfileColor
        , height (fill |> Element.maximum 275)
        , Border.rounded 6
        , Element.spacingXY 0 20
        ]
        [ -- HardCoded Spacing xD
          el [] <| text "     "

        -- Image's Profile
        , el []
            (image
                [ Border.rounded 500
                , Element.clip
                , width <| Element.px 250
                , height <| Element.px 250
                , Border.color <| primaryBrown
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
                    { url = "https://fonts.googleapis.com/css2?family=IBM+Plex+Serif:ital,wght@0,500;0,700;1,500"
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
                , Font.color <| primaryBrown
                ]
                (text "Luis Ilarraza")
            , el
                [ Font.color <| red
                , Element.paddingXY 0 20
                , Font.size 32
                , Font.italic
                ]
                (text "Programmer & Freelancer")
            ]
        ]


actualContent model =
    column
        [ centerX
        , Element.alignBottom
        , width
            (fill |> Element.maximum 1000)
        , Background.color <| lightBg
        , height (fill |> Element.maximum 500)
        , Border.rounded 6
        ]
        [ menubar model
        , model.content
        ]


menubar model =
    row
        [ Element.alignTop
        , Background.color <| darkBg
        , width fill
        , Border.roundEach
            { bottomLeft = 0
            , bottomRight = 0
            , topLeft = 6
            , topRight = 6
            }
        , spacing 10
        ]
        [ portaButton "Inicio" (Just Inicio) model
        , portaButton "Proyectos" (Just Proyectos) model
        , portaButton "Contacto" (Just Contacto) model
        ]


portaButton : String -> Maybe Msg -> Model -> Element Msg
portaButton txt action model =
    Input.button
        [ Background.color <| darkest
        , Font.color <| primaryBrown
        , Font.family
            [ Font.typeface "IBM Plex Serif"
            , Font.sansSerif
            ]
        , padding 10
        , centerX
        , Border.widthEach
            { bottom = 3
            , left = 0
            , right = 0
            , top = 3
            }
        , Border.color <| primaryBrown
        , Element.mouseOver
            [ Background.color <| primaryBrown
            , Font.color <| darkest
            , Border.color <| darkest
            ]
        ]
        { onPress = action, label = text txt }


welcome : Element Msg
welcome =
    Element.textColumn [ Element.alignTop, centerX, Font.family [ Font.typeface "IBM Plex Serif" ], Font.color <| primaryBrown ]
        [ el [ Font.bold, Font.center, Element.paddingXY 0 15 ] (text "Introducción")
        , paragraph [ Font.justify ] [ text "Hola, bienvenidos a mi portafolio" ]
        ]


proyectos : Element Msg
proyectos =
    column [ Element.alignTop, centerX, Element.spacing 20 ]
        [ row [] [ el [] (text "Proyects") ]
        , row [] [ el [] (text "Here!") ]
        ]


contacto : Element Msg
contacto =
    row [ Element.alignTop, centerX ]
        [ el [] (text "contact here!")
        ]
