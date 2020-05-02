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
import FontAwesome.Brands as IconsBrands
import FontAwesome.Icon as Icon
import FontAwesome.Solid as IconsSolid


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


blue =
    rgb255 153 194 196


darkBg =
    rgb255 50 48 47


darkest =
    rgb255 40 40 40


lightBg =
    rgba255 60 56 54 0.9


view : Model -> Browser.Document Msg
view model =
    Browser.Document "Portafolio" <|
        [ Element.layoutWith
            { options =
                [ Element.focusStyle <|
                    Element.FocusStyle (Just primaryBrown) Nothing Nothing
                ]
            }
            [ Background.color <| darkest
            , Background.image "https://images.unsplash.com/photo-1503252947848-7338d3f92f31"
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
        , el [] <|
            image
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
            , el
                [ Font.color <| blue
                , Element.paddingXY 0 0
                , Font.size 32
                , Font.italic
                ]
                (text "Full Stack Developer")
            ]
        ]


actualContent model =
    column
        [ centerX
        , Element.alignBottom
        , width (fill |> Element.maximum 1000)
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
    Element.textColumn
        [ Element.alignTop
        , centerX
        , Font.family
            [ Font.typeface "IBM Plex Serif"
            ]
        , Font.color <| primaryBrown
        ]
        [ el
            [ Font.bold
            , Font.center
            , Element.paddingXY 0 30
            , Font.underline
            , Font.size 26
            ]
            (-- In Spanish
             text "Sobre mí"
             -- In English
             -- text "About me"
            )
        , paragraph [ Font.justify, spacing 10 ]
            [ -- In Spanish
              text """Soy un estudiante universitario de informática
                        culminando mi carrera, la cual disfruto mucho
                        por lo cual siempre amplio mis horizontes en la
                        informatica, ya que tengo muchos campos de
                        intereses relacionados a ella, desde el
                        desarrollo web hasta el de videojuegos, ultimamente
                        dedicandome más a lo primero, trabajo en """

            -- In English
            -- text """I am a venezolan college student in Computer Sciences
            --            finishing my career, which enjoy a lot studying it
            --            constantly  because i have many interests in those
            --            fields, from Web development until videogames development, althought
            --            ultimately i dedicate more time at first of them, besides I am work in """
            , Element.newTabLink [ Font.underline ]
                { url = "https://ereditadigital.com"
                , label = text "Eredità Digital"
                }
            , -- In Spanish
              text """ como administrador de sistemas y soy freelancer
                        en mi tiempo libre, es por esa razón tomo mi
                        trabajo como algo personal, “Hacer lo que amo
                        y amar lo que hago” siento que esa frase es
                        importante para un programador, por esa razón
                        me gusta enfrentarme a nuevos desafíos
                        constantemente, siempre tomando en cuenta mi afán
                        por el Software Libre y a los Sistemas Operativos
                        tipo UNIX mientras lo hago."""

            -- In English
            -- text """ and I am freelancer in my freetime,
            --         simply “Doing what i love it and loving what i do it”
            --         actually expressing something important to me, since
            --         i like learn new techs and programming languages,
            --         so i think that the curiosity it's a
            --         weapon for any programmer, and it's the reason because
            --         i've never stop to learning and i advocate the Open Source
            --         and Free Software, plus of i love UNIX-like Operating Systems."""
            ]
        ]


proyectos : Element Msg
proyectos =
    column [ Element.spacing 20, width fill, height fill ]
        [ row [ Element.spacingXY 20 0, centerX, centerY, width fill ]
            [ commonProject "SAICyR" IconsBrands.php
            , commonProject "Chami" IconsBrands.wordpress
            , commonProject "React-Calc" IconsBrands.react
            ]
        , row [ Element.spacingXY 20 0, centerX, centerY, width fill ]
            [ commonProject "Herramientas" IconsBrands.php
            , commonProject "Recipes" IconsBrands.php
            , commonProject "Dollars-App" IconsBrands.react
            ]
        ]


contacto : Element Msg
contacto =
    row [ Element.alignTop, width fill, height fill, spacing 10 ]
        [ linkSocial "Github" "https://github.com/it6c65" IconsBrands.github
        , linkSocial "Linkedin" "https://www.linkedin.com/in/luis-ilarraza-335a34195" IconsBrands.linkedin
        , linkSocial "Correo" "mailto://ilarrazaluis82@gmail.com" IconsSolid.envelope
        , linkSocial "Telegram" "https://t.me/it6c65" IconsBrands.telegram
        ]


commonProject : String -> Icon.Icon -> Element Msg
commonProject name icon =
    column
        [ Background.color darkBg
        , Font.color primaryBrown
        , Border.rounded 6
        , padding 10
        , height (fill
                 |> Element.maximum 300
                 |> Element.minimum 200
                 )
        , width (fill
                |> Element.maximum 300
                |> Element.minimum 200
                )
        , centerX
        ]
        [
         el
            [ Font.color primaryBrown
            , centerX
            , centerY
            , height (fill |> Element.maximum 120)
            , width (fill |> Element.maximum 120)
            , Element.paddingXY 0 15
            ]
            (Element.html <| Icon.viewIcon icon)
         , el [ centerX, centerY ] (text name)
        ]


linkSocial : String -> String -> Icon.Icon -> Element Msg
linkSocial web url icon =
    column
        [ Font.color primaryBrown
        , height fill
        , width fill
        , centerY
        , Element.mouseOver [ Background.color darkBg ]
        ]
        [ Element.newTabLink [ centerY, height fill ]
            { url = url
            , label =
                column [ height fill ]
                    [ el
                        [ centerY
                        , centerX
                        , height (fill |> Element.maximum 120)
                        , Element.paddingXY 0 15
                        ]
                        (Element.html <| Icon.viewIcon icon)
                    , el [ centerY, centerX ] (text web)
                    ]
            }
        ]
