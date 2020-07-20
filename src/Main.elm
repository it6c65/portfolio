module Main exposing (..)

import Browser
import Browser.Events exposing (onResize)
import Element
    exposing
        ( Device
        , DeviceClass(..)
        , Element
        , Orientation(..)
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
import Html exposing (Html)
import Color



-- Main


main =
    Browser.document { init = init, update = update, view = view, subscriptions = subscriptions }



-- init


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( Model about (Element.classifyDevice flags) (String.left 2 flags.lang), Cmd.none )



-- Principal Message


type Msg
    = Home
    | Services
    | Projects
    | Abilities
    | Contact
    | Responsive Device



-- Model


type alias Flags =
    { width : Int
    , height : Int
    , lang : String
    }


type alias Model =
    { content : Element Msg, device : Device, lang : String }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Home ->
            ( Model about model.device model.lang, Cmd.none )

        Services ->
            ( Model (services model) model.device model.lang, Cmd.none )

        Projects ->
            ( Model (projects model) model.device model.lang, Cmd.none )

        Abilities ->
            ( Model (abilities model) model.device model.lang, Cmd.none )

        Contact ->
            ( Model (contact model) model.device model.lang, Cmd.none )

        Responsive device ->
            ( { model | device = device }, Cmd.none )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    onResize <|
        \width height ->
            Responsive (Element.classifyDevice { width = width, height = height })



-- Final View


view : Model -> Browser.Document Msg
view model =
    Browser.Document "Portafolio" (body model)


body : Model -> List (Html Msg)
body model =
    case model.device.class of
        Phone ->
            frontMobile model

        _ ->
            frontDesktop model



-- Layout Phone


frontMobile : Model -> List (Html Msg)
frontMobile model =
    [ Element.layoutWith
        { options =
            [ Element.focusStyle <|
                Element.FocusStyle (Just Color.primaryBrown) Nothing Nothing
            ]
        }
        [ Background.color <| Color.darkest ]
        (cover model)
    ]



-- Layout Desktop


frontDesktop : Model -> List (Html Msg)
frontDesktop model =
    [ Element.layoutWith
        { options =
            [ Element.focusStyle <|
                Element.FocusStyle (Just Color.primaryBrown) Nothing Nothing
            ]
        }
        [ Background.image "imgs/bg.jpg" ]
        (cover model)
    ]



-- Page Cover


cover model =
    column [ width fill, height fill, centerY ]
        [ profile model, actualContent model ]



-- Profile's Up


profile model =
    case model.device.class of
        Phone ->
            row
                [ centerX
                , Element.alignTop
                , width fill
                , Background.color <| Color.bgProfileColor
                , height fill
                , Border.rounded 6
                , Element.spacingXY 0 20
                ]
                [ -- Image's Profile
                  imageProfile model

                -- Letters & title
                , descProfile model
                ]

        _ ->
            row
                [ centerX
                , Element.alignTop
                , width (fill |> Element.maximum 800)
                , Background.color <| Color.bgProfileColor
                , height (fill |> Element.maximum 275)
                , Border.rounded 6
                , Element.spacingXY 0 20
                ]
                [ -- HardCoded Spacing xD
                  el [] <| text "     "

                -- Image's Profile
                , imageProfile model

                -- Letters & title
                , descProfile model
                ]


imageProfile model =
    case model.device.class of
        Phone ->
            Element.none

        _ ->
            el [] <|
                image
                    [ Border.rounded 500
                    , Element.clip
                    , width <| Element.px 250
                    , height <| Element.px 250
                    , Border.color <| Color.primaryBrown
                    , Border.width 6
                    ]
                    { src = "imgs/me.jpg"
                    , description = "Photo_Me"
                    }


descProfile model =
    case model.device.class of
        Phone ->
            Element.textColumn
                [ centerX
                , width Element.shrink
                , Element.alignTop
                , Element.paddingXY 0 20
                , Font.family
                    [ Font.typeface "Times New Roman"
                    , Font.serif
                    ]
                ]
                [ el
                    [ Font.size 62
                    , Font.color <| Color.primaryBrown
                    , Font.center
                    ]
                    (text my.name)
                , el
                    [ Font.color <| Color.red
                    , Element.paddingXY 0 20
                    , Font.size 32
                    , Font.italic
                    , Font.center
                    ]
                    (text my.job)
                , el
                    [ Font.color <| Color.blue
                    , Element.paddingXY 0 0
                    , Font.size 32
                    , Font.italic
                    , Font.center
                    ]
                    (text my.profession)
                ]

        Tablet ->
            column
                [ centerX
                , Element.alignTop
                , Element.paddingXY 0 40
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
                    , Font.color <| Color.primaryBrown
                    ]
                    (text my.name)
                , el
                    [ Font.color <| Color.red
                    , Element.paddingXY 0 20
                    , Font.size 32
                    , Font.italic
                    ]
                    (text my.job)
                , el
                    [ Font.color <| Color.blue
                    , Element.paddingXY 0 0
                    , Font.size 32
                    , Font.italic
                    ]
                    (text my.profession)
                ]

        _ ->
            column
                [ centerX
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
                    , Font.color <| Color.primaryBrown
                    ]
                    (text my.name)
                , el
                    [ Font.color <| Color.red
                    , Element.paddingXY 0 20
                    , Font.size 32
                    , Font.italic
                    ]
                    (text my.job)
                , el
                    [ Font.color <| Color.blue
                    , Element.paddingXY 0 0
                    , Font.size 32
                    , Font.italic
                    ]
                    (text my.profession)
                ]



-- Box content of the all content


actualContent model =
    case model.device.class of
        Phone ->
            column
                [ centerX
                , Element.alignBottom
                , width fill
                , Background.color <| Color.lightBg
                , height fill
                , Border.rounded 6
                ]
                [ menubar model
                , model.content
                ]

        Tablet ->
            column
                [ centerX
                , Element.alignBottom
                , width fill
                , Background.color <| Color.lightBg
                , height fill
                , Border.rounded 6
                ]
                [ menubar model
                , model.content
                ]

        _ ->
            column
                [ centerX
                , Element.alignBottom
                , width (fill |> Element.maximum 1000)
                , Background.color <| Color.lightBg
                , height (fill |> Element.maximum 500)
                , Border.rounded 6
                ]
                [ menubar model
                , model.content
                ]



-- Navbar


menubar model =
    case model.device.class of
        Phone ->
            column
                [ Element.alignTop
                , Background.color <| Color.darkBg
                , width fill
                , Border.roundEach
                    { bottomLeft = 0
                    , bottomRight = 0
                    , topLeft = 6
                    , topRight = 6
                    }
                ]
                [ portaButton "Inicio" (Just Home) model
                , portaButton "Servicios" (Just Services) model
                , portaButton "Proyectos" (Just Projects) model
                , portaButton "Habilidades" (Just Abilities) model
                , portaButton "Contacto" (Just Contact) model
                ]

        Tablet ->
            case model.device.orientation of
                Portrait ->
                    column
                        [ Element.alignTop
                        , Background.color <| Color.darkBg
                        , width fill
                        , Border.roundEach
                            { bottomLeft = 0
                            , bottomRight = 0
                            , topLeft = 6
                            , topRight = 6
                            }
                        , spacing 10
                        ]
                        [ portaButton "Inicio" (Just Home) model
                        , portaButton "Servicios" (Just Services) model
                        , portaButton "Proyectos" (Just Projects) model
                        , portaButton "Habilidades" (Just Abilities) model
                        , portaButton "Contacto" (Just Contact) model
                        ]

                Landscape ->
                    row
                        [ Element.alignTop
                        , Background.color <| Color.darkBg
                        , width fill
                        , Border.roundEach
                            { bottomLeft = 0
                            , bottomRight = 0
                            , topLeft = 6
                            , topRight = 6
                            }
                        , spacing 10
                        ]
                        [ portaButton "Inicio" (Just Home) model
                        , portaButton "Servicios" (Just Services) model
                        , portaButton "Proyectos" (Just Projects) model
                        , portaButton "Habilidades" (Just Abilities) model
                        , portaButton "Contacto" (Just Contact) model
                        ]

        _ ->
            row
                [ Element.alignTop
                , Background.color <| Color.darkBg
                , width fill
                , Border.roundEach
                    { bottomLeft = 0
                    , bottomRight = 0
                    , topLeft = 6
                    , topRight = 6
                    }
                , spacing 10
                ]
                [ portaButton "Inicio" (Just Home) model
                , portaButton "Servicios" (Just Services) model
                , portaButton "Proyectos" (Just Projects) model
                , portaButton "Habilidades" (Just Abilities) model
                , portaButton "Contacto" (Just Contact) model
                ]


portaButton : String -> Maybe Msg -> Model -> Element Msg
portaButton txt action model =
    case model.device.class of
        Phone ->
            Input.button
                [ Background.color <| Color.darkest
                , Font.color <| Color.primaryBrown
                , Font.family
                    [ Font.typeface "IBM Plex Serif"
                    , Font.sansSerif
                    ]
                , padding 10
                , centerX
                , width fill
                , Border.widthEach
                    { bottom = 3
                    , left = 0
                    , right = 0
                    , top = 3
                    }
                , Border.color <| Color.primaryBrown
                , Element.mouseOver
                    [ Background.color <| Color.primaryBrown
                    , Font.color <| Color.darkest
                    , Border.color <| Color.darkest
                    ]
                ]
                { onPress = action, label = text txt }

        Tablet ->
            Input.button
                [ Background.color <| Color.darkest
                , Font.color <| Color.primaryBrown
                , Font.center
                , Font.family
                    [ Font.typeface "IBM Plex Serif"
                    , Font.sansSerif
                    ]
                , padding 10
                , centerX
                , width fill
                , Border.widthEach
                    { bottom = 3
                    , left = 0
                    , right = 0
                    , top = 3
                    }
                , Border.color <| Color.primaryBrown
                , Element.mouseOver
                    [ Background.color <| Color.primaryBrown
                    , Font.color <| Color.darkest
                    , Border.color <| Color.darkest
                    ]
                ]
                { onPress = action, label = text txt }

        _ ->
            Input.button
                [ Background.color <| Color.darkest
                , Font.color <| Color.primaryBrown
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
                , Border.color <| Color.primaryBrown
                , Element.mouseOver
                    [ Background.color <| Color.primaryBrown
                    , Font.color <| Color.darkest
                    , Border.color <| Color.darkest
                    ]
                ]
                { onPress = action, label = text txt }



-- Pages Content


about : Element Msg
about =
    Element.textColumn
        [ Element.alignTop
        , centerX
        , Font.family
            [ Font.typeface "IBM Plex Serif"
            ]
        , Font.color <| Color.primaryBrown
        , width fill
        , height fill
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
        , paragraph [ Font.justify, spacing 10, padding 20 ]
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


abilities : Model -> Element Msg
abilities model =
    case model.device.class of
        Phone ->
            column
                [ Element.alignTop
                , centerX
                , Font.family
                    [ Font.typeface "IBM Plex Serif"
                    ]
                , Font.color <| Color.primaryBrown
                , height fill
                , width fill
                , Element.scrollbarY
                ]
                [ el
                    [ Font.bold
                    , centerX
                    , Element.paddingXY 0 30
                    , Font.underline
                    , Font.size 26
                    ]
                    (-- In Spanish
                     text "Habilidades"
                     -- In English
                     -- text "Abilities"
                    )
                , column [ width fill, height fill ]
                    [ column [ centerX, spacing 30, width fill ]
                        [ column
                            [ centerX
                            , width fill
                            , spacing 20
                            , padding 40
                            , Element.alignTop
                            ]
                            [ el
                                [ Font.color Color.primaryBrown
                                , Font.underline
                                , centerX
                                , Background.color Color.darkBg
                                , padding 15
                                ]
                                (text "Programación")
                            , abilityProgress "PHP" IconsBrands.php (progressBar 8)
                            , abilityProgress "JavaScript" IconsBrands.js (progressBar 7)
                            , abilityProgress "Ruby" IconsSolid.gem (progressBar 6)
                            , abilityProgressImage "Elm" "imgs/elm.png" (progressBar 6)
                            ]
                        , column
                            [ centerX
                            , width fill
                            , spacing 20
                            , padding 40
                            , Element.alignTop
                            ]
                            [ el
                                [ Font.color Color.primaryBrown
                                , Font.underline
                                , centerX
                                , Background.color Color.darkBg
                                , padding 15
                                ]
                                (text "Frameworks")
                            , abilityProgressImage "CodeIgniter" "imgs/ci.png" (progressBar 8)
                            , abilityProgress "React" IconsBrands.react (progressBar 7.5)
                            , abilityProgress "Vue" IconsBrands.vuejs (progressBar 6)
                            , abilityProgress "Laravel" IconsBrands.laravel (progressBar 6)
                            , abilityProgressImage "Ruby on Rails" "imgs/rails.png" (progressBar 4)
                            ]
                        ]
                    , column [ centerX, spacing 30, width fill, Element.paddingXY 0 20 ]
                        [ column
                            [ centerX
                            , width fill
                            , spacing 20
                            , padding 40
                            , Element.alignTop
                            ]
                            [ el
                                [ Font.color Color.primaryBrown
                                , Font.underline
                                , centerX
                                , Background.color Color.darkBg
                                , padding 15
                                ]
                                (text "Sistemas Operativos")
                            , abilityProgress "Ubuntu" IconsBrands.ubuntu (progressBar 8.5)
                            , abilityProgress "FreeBSD" IconsBrands.freebsd (progressBar 6)
                            , abilityProgress "CentOS" IconsBrands.centos (progressBar 3.5)
                            ]
                        , column
                            [ centerX
                            , width fill
                            , spacing 20
                            , padding 40
                            , Element.alignTop
                            ]
                            [ el
                                [ Font.color Color.primaryBrown
                                , Font.underline
                                , centerX
                                , Background.color Color.darkBg
                                , padding 15
                                ]
                                (text "Web")
                            , abilityProgress "HTML" IconsBrands.html5 (progressBar 10)
                            , abilityProgress "CSS" IconsBrands.css3 (progressBar 8)
                            , abilityProgress "Wordpress" IconsBrands.wordpressSimple (progressBar 6)
                            ]
                        ]
                    ]
                ]

        _ ->
            column
                [ Element.alignTop
                , centerX
                , Font.family
                    [ Font.typeface "IBM Plex Serif"
                    ]
                , Font.color <| Color.primaryBrown
                , height fill
                , width fill
                , Element.scrollbarY
                ]
                [ el
                    [ Font.bold
                    , centerX
                    , Element.paddingXY 0 30
                    , Font.underline
                    , Font.size 26
                    ]
                    (-- In Spanish
                     text "Habilidades"
                     -- In English
                     -- text "Abilities"
                    )
                , column [ width fill, height fill ]
                    [ row [ centerX, spacing 30, width fill ]
                        [ column
                            [ centerX
                            , width fill
                            , spacing 20
                            , padding 40
                            , Element.alignTop
                            ]
                            [ el
                                [ Font.color Color.primaryBrown
                                , Font.underline
                                , centerX
                                , Background.color Color.darkBg
                                , padding 15
                                ]
                                (text "Programación")
                            , abilityProgress "PHP" IconsBrands.php (progressBar 8)
                            , abilityProgress "JavaScript" IconsBrands.js (progressBar 7)
                            , abilityProgress "Ruby" IconsSolid.gem (progressBar 6)
                            , abilityProgressImage "Elm" "imgs/elm.png" (progressBar 6)
                            ]
                        , column
                            [ centerX
                            , width fill
                            , spacing 20
                            , padding 40
                            , Element.alignTop
                            ]
                            [ el
                                [ Font.color Color.primaryBrown
                                , Font.underline
                                , centerX
                                , Background.color Color.darkBg
                                , padding 15
                                ]
                                (text "Frameworks")
                            , abilityProgressImage "CodeIgniter" "imgs/ci.png" (progressBar 8)
                            , abilityProgress "React" IconsBrands.react (progressBar 7.5)
                            , abilityProgress "Vue" IconsBrands.vuejs (progressBar 6)
                            , abilityProgress "Laravel" IconsBrands.laravel (progressBar 6)
                            , abilityProgressImage "Ruby on Rails" "imgs/rails.png" (progressBar 4)
                            ]
                        ]
                    , row [ centerX, spacing 30, width fill, Element.paddingXY 0 20 ]
                        [ column
                            [ centerX
                            , width fill
                            , spacing 20
                            , padding 40
                            , Element.alignTop
                            ]
                            [ el
                                [ Font.color Color.primaryBrown
                                , Font.underline
                                , centerX
                                , Background.color Color.darkBg
                                , padding 15
                                ]
                                (text "Sistemas Operativos")
                            , abilityProgress "Ubuntu" IconsBrands.ubuntu (progressBar 8.5)
                            , abilityProgress "FreeBSD" IconsBrands.freebsd (progressBar 6)
                            , abilityProgress "CentOS" IconsBrands.centos (progressBar 3.5)
                            ]
                        , column
                            [ centerX
                            , width fill
                            , spacing 20
                            , padding 40
                            , Element.alignTop
                            ]
                            [ el
                                [ Font.color Color.primaryBrown
                                , Font.underline
                                , centerX
                                , Background.color Color.darkBg
                                , padding 15
                                ]
                                (text "Web")
                            , abilityProgress "HTML" IconsBrands.html5 (progressBar 10)
                            , abilityProgress "CSS" IconsBrands.css3 (progressBar 8)
                            , abilityProgress "Wordpress" IconsBrands.wordpressSimple (progressBar 6)
                            ]
                        ]
                    ]
                ]


projects : Model -> Element Msg
projects model =
    case model.device.class of
        Phone ->
            column [ Element.spacing 20, width fill, height fill ]
                [ el
                    [ Font.bold
                    , centerX
                    , Element.paddingXY 0 30
                    , Font.underline
                    , Font.family [ Font.typeface "IBM Plex Serif" ]
                    , Font.size 26
                    , Font.color <| Color.primaryBrown
                    ]
                    (text "Proyectos")
                , commonProject "SAICyR" IconsBrands.php (my.git ++ "/SAICyR")
                , commonProject "Chami" IconsBrands.wordpress ""
                , commonProject "React-Calc" IconsBrands.react (my.ghPage ++ "calc-react")
                , commonProject "Herramientas" IconsBrands.php (my.git ++ "/sdgh")
                , commonProject "Recipes" IconsBrands.php ""
                , commonProject "Dollars-App" IconsBrands.react (my.ghPage ++ "dollars-app")
                ]

        _ ->
            column [ Element.spacing 20, width fill, height fill, Element.scrollbarY ]
                [ row [ Element.spacingXY 20 0, centerX, centerY, width fill ]
                    [ el
                        [ Font.bold
                        , centerX
                        , Element.paddingXY 0 30
                        , Font.underline
                        , Font.size 26
                        , Font.family [ Font.typeface "IBM Plex Serif" ]
                        , Font.color <| Color.primaryBrown
                        ]
                        (text "Proyectos")
                    ]
                , row [ Element.spacingXY 20 0, centerX, centerY, width fill ]
                    [ commonProject "SAICyR" IconsBrands.php (my.git ++ "/SAICyR")
                    , commonProject "Chami" IconsBrands.wordpress ""
                    , commonProject "React-Calc" IconsBrands.react (my.ghPage ++ "calc-react")
                    ]
                , row [ Element.spacingXY 20 0, centerX, centerY, width fill ]
                    [ commonProject "Herramientas" IconsBrands.php (my.git ++ "/sdgh")
                    , commonProject "Recipes" IconsBrands.php ""
                    , commonProject "Dollars-App" IconsBrands.react (my.ghPage ++ "dollars-app")
                    ]
                ]


contact : Model -> Element Msg
contact model =
    case model.device.class of
        Phone ->
            column [ Element.alignTop, width fill, height fill, spacing 10 ]
                [ linkSocial "Github" my.git IconsBrands.github
                , linkSocial "Linkedin" my.linkedin IconsBrands.linkedin
                , linkSocial "Correo" my.email IconsSolid.envelope
                , linkSocial "Telegram" my.telegram IconsBrands.telegram
                ]

        _ ->
            row [ Element.alignTop, width fill, height fill, spacing 10 ]
                [ linkSocial "Github" my.git IconsBrands.github
                , linkSocial "Linkedin" my.linkedin IconsBrands.linkedin
                , linkSocial "Correo" my.email IconsSolid.envelope
                , linkSocial "Telegram" my.telegram IconsBrands.telegram
                ]


services : Model -> Element Msg
services model =
    case model.device.class of
        Phone ->
            column
                [ Element.alignTop
                , centerX
                , Font.family [ Font.typeface "IBM Plex Serif" ]
                , Font.color <| Color.primaryBrown
                , height fill
                , width fill
                , Element.scrollbarY
                ]
                [ el
                    [ Font.bold
                    , centerX
                    , Element.paddingXY 0 30
                    , Font.underline
                    , Font.size 26
                    ]
                    (-- In Spanish
                     text "Servicios"
                     -- In English
                     -- text "Services"
                    )
                , column []
                    [ Element.textColumn [ Font.justify, spacing 10 ]
                        [ el [ Font.bold ] (text "• Desarrollo Web")
                        , el [ Element.paddingXY 20 5 ] (text "ø Vista (Front)")
                        , el [ Element.paddingXY 20 5 ] (text "ø Servidor (Back)")
                        , el [ Element.paddingXY 20 5 ] (text "ø Toda (Full)")
                        , el [ Font.bold ] (text "• Creacion de Temas")
                        , el [ Element.paddingXY 20 5 ] (text "ø Wordpress")
                        , el [ Element.paddingXY 20 5 ] (text "ø OpenCart")
                        , el [ Element.paddingXY 20 5 ] (text "ø Omeka")
                        ]
                    , Element.textColumn [ Font.justify, spacing 10 ]
                        [ el [ Font.bold ] (text "• Diseño de Logos")
                        , el [ Font.bold ] (text "• Montar aplicacion en servidor")
                        , el [ Element.paddingXY 20 5 ] (text "ø Wordpress")
                        , el [ Element.paddingXY 20 5 ] (text "ø OpenCart")
                        , el [ Element.paddingXY 20 5 ] (text "ø Omeka")
                        , el [ Font.bold ] (text "• Traducciones")
                        ]
                    ]
                ]

        _ ->
            column
                [ Element.alignTop
                , centerX
                , Font.family [ Font.typeface "IBM Plex Serif" ]
                , Font.color <| Color.primaryBrown
                , height fill
                , width fill
                , Element.scrollbarY
                ]
                [ el
                    [ Font.bold
                    , centerX
                    , Element.paddingXY 0 30
                    , Font.underline
                    , Font.size 26
                    ]
                    (-- In Spanish
                     text "Servicios"
                     -- In English
                     -- text "Services"
                    )
                , row []
                    [ Element.textColumn [ Font.justify, spacing 10, Element.paddingXY 80 20, Element.alignTop ]
                        [ el [ Font.bold ] (text "• Desarrollo Web")
                        , el [ Element.paddingXY 20 5 ] (text "ø Vista (Front)")
                        , el [ Element.paddingXY 20 5 ] (text "ø Servidor (Back)")
                        , el [ Element.paddingXY 20 5 ] (text "ø Toda (Full)")
                        , el [ Font.bold ] (text "• Creacion de Temas")
                        , el [ Element.paddingXY 20 5 ] (text "ø Wordpress")
                        , el [ Element.paddingXY 20 5 ] (text "ø OpenCart")
                        , el [ Element.paddingXY 20 5 ] (text "ø Omeka")
                        ]
                    , Element.textColumn [ Font.justify, spacing 10, Element.paddingXY 30 20, Element.alignTop ]
                        [ el [ Font.bold ] (text "• Diseño de Logos")
                        , el [ Font.bold ] (text "• Montar aplicacion en servidor")
                        , el [ Element.paddingXY 20 5 ] (text "ø Wordpress")
                        , el [ Element.paddingXY 20 5 ] (text "ø OpenCart")
                        , el [ Element.paddingXY 20 5 ] (text "ø Omeka")
                        , el [ Font.bold ] (text "• Traducciones")
                        ]
                    ]
                ]



-- View helpers


commonProject : String -> Icon.Icon -> String -> Element Msg
commonProject name icon url =
    if String.isEmpty url then
        column
            [ Background.color Color.darkBg
            , Font.color Color.primaryBrown
            , Border.rounded 6
            , padding 10
            , spacing 10
            , height
                (fill
                    |> Element.maximum 300
                    |> Element.minimum 200
                )
            , width
                (fill
                    |> Element.maximum 300
                    |> Element.minimum 200
                )
            , centerX
            ]
            [ el
                [ Font.color Color.primaryBrown
                , centerX
                , centerY
                , height (fill |> Element.maximum 120)
                , width (fill |> Element.maximum 120)
                , Element.paddingXY 0 15
                ]
                (Element.html <| Icon.viewIcon icon)
            , el [ centerX, centerY ] (text name)
            , el
                [ centerX
                , centerY
                , Font.color <| Color.darkBg
                , Font.size 12
                , Background.color <| Color.primaryBrown
                , Border.rounded 10
                , padding 4
                ]
                (text "En Construccion")
            ]

    else
        column
            [ Background.color Color.darkBg
            , Font.color Color.primaryBrown
            , Border.rounded 6
            , padding 10
            , height
                (fill
                    |> Element.maximum 300
                    |> Element.minimum 200
                )
            , width
                (fill
                    |> Element.maximum 300
                    |> Element.minimum 200
                )
            , centerX
            ]
            [ Element.newTabLink [ width fill, height fill ]
                { url = url
                , label =
                    column [ width fill, height fill ]
                        [ el
                            [ Font.color Color.primaryBrown
                            , centerX
                            , centerY
                            , height (fill |> Element.maximum 120)
                            , width (fill |> Element.maximum 120)
                            , Element.paddingXY 0 15
                            ]
                            (Element.html <| Icon.viewIcon icon)
                        , el [ centerX, centerY ] (text name)
                        ]
                }
            ]


linkSocial : String -> String -> Icon.Icon -> Element Msg
linkSocial web url icon =
    column
        [ Font.color Color.primaryBrown
        , height fill
        , width fill
        , padding 10
        , centerY
        , Element.mouseOver [ Background.color Color.darkBg ]
        ]
        [ Element.newTabLink [ centerX, centerY, height fill, width fill ]
            { url = url
            , label =
                column [ height fill, width fill ]
                    [ el
                        [ Font.color Color.primaryBrown
                        , centerY
                        , centerX
                        , height (fill |> Element.maximum 120)
                        , width (fill |> Element.maximum 120)
                        , Element.paddingXY 0 15
                        ]
                        (Element.html <| Icon.viewIcon icon)
                    , el [ centerY, centerX ] (text web)
                    ]
            }
        ]


abilityProgress : String -> Icon.Icon -> String -> Element Msg
abilityProgress name icon progress =
    row [ centerX, spacing 20 ]
        [ column []
            [ el [ centerX ] (text name)
            , row [ spacing 20 ]
                [ el
                    [ Font.color Color.primaryBrown
                    , height
                        (fill
                            |> Element.maximum 72
                            |> Element.minimum 60
                        )
                    , width
                        (fill
                            |> Element.maximum 72
                            |> Element.minimum 60
                        )
                    , centerY
                    ]
                    (Element.html <| Icon.viewIcon icon)
                , el [ centerY ] (text <| progress)
                ]
            ]
        ]


abilityProgressImage : String -> String -> String -> Element Msg
abilityProgressImage name url progress =
    row [ centerX, spacing 20 ]
        [ column []
            [ el [ centerX ] (text name)
            , row [ spacing 20 ]
                [ el
                    [ Font.color Color.primaryBrown
                    , centerY
                    ]
                    (Element.image
                        [ height
                            (fill
                                |> Element.maximum 72
                                |> Element.minimum 60
                            )
                        , width
                            (fill
                                |> Element.maximum 72
                                |> Element.minimum 60
                            )
                        ]
                        { src = url
                        , description = name
                        }
                    )
                , el [ centerY ] (text <| progress)
                ]
            ]
        ]


progressBar : Float -> String
progressBar points =
    String.repeat (ceiling points) "█"
        ++ String.repeat (10 - ceiling points) "░"
        ++ "    "
        ++ String.fromFloat (points / 10 * 100)
        ++ "%"



-- Static Data


protocol =
    { mail = "mailto://"
    , link = "https://"
    }


my =
    { name = "Luis ilarraza"
    , job = "Programmer Freelancer"
    , profession = "Full Stack Developer"
    , ghPage = protocol.link ++ "it6c65.github.io/"

    -- Social Links
    , telegram = protocol.link ++ "t.me/it6c65"
    , linkedin = protocol.link ++ "www.linkedin.com/in/luis-ilarraza-335a34195"
    , git = protocol.link ++ "github.com/it6c65"
    , email = protocol.mail ++ "enrique_ila@hotmail.com"
    }
