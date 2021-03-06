module Main exposing (..)

import Browser
import Browser.Events exposing (onResize)
import Color
import Data exposing (my, progressBar)
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



-- Main


main =
    Browser.document { init = init, update = update, view = view, subscriptions = subscriptions }



-- init


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        lang =
            String.left 2 flags.lang
    in
    ( Model (about lang) (Element.classifyDevice flags) lang, Cmd.none )



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
            ( Model (about model.lang) model.device model.lang, Cmd.none )

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
    let
        documentTitle =
            if model.lang == "es" then
                Data.spanish.main

            else
                Data.english.main
    in
    Browser.Document documentTitle (body model)


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
        [ Background.image Data.images.background ]
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
                    { src = Data.images.photo
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
    let
        aboutTitle =
            if model.lang == "es" then
                Data.spanish.about

            else
                Data.english.about

        servicesTitle =
            if model.lang == "es" then
                Data.spanish.services.title

            else
                Data.english.services.title

        projectsTitle =
            if model.lang == "es" then
                Data.spanish.projects

            else
                Data.english.projects

        skillsTitle =
            if model.lang == "es" then
                Data.spanish.skills

            else
                Data.english.skills

        contactTitle =
            if model.lang == "es" then
                Data.spanish.contact

            else
                Data.english.contact
    in
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
                [ portaButton aboutTitle (Just Home) model
                , portaButton servicesTitle (Just Services) model
                , portaButton projectsTitle (Just Projects) model
                , portaButton skillsTitle (Just Abilities) model
                , portaButton contactTitle (Just Contact) model
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
                        [ portaButton aboutTitle (Just Home) model
                        , portaButton servicesTitle (Just Services) model
                        , portaButton projectsTitle (Just Projects) model
                        , portaButton skillsTitle (Just Abilities) model
                        , portaButton contactTitle (Just Contact) model
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
                        [ portaButton aboutTitle (Just Home) model
                        , portaButton servicesTitle (Just Services) model
                        , portaButton projectsTitle (Just Projects) model
                        , portaButton skillsTitle (Just Abilities) model
                        , portaButton contactTitle (Just Contact) model
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
                [ portaButton aboutTitle (Just Home) model
                , portaButton servicesTitle (Just Services) model
                , portaButton projectsTitle (Just Projects) model
                , portaButton skillsTitle (Just Abilities) model
                , portaButton contactTitle (Just Contact) model
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


about : String -> Element Msg
about lang =
    let
        aboutTitle =
            if lang == "es" then
                Data.spanish.about

            else
                Data.english.about

        descriptionPartOne =
            if lang == "es" then
                Data.spanish.description.part1

            else
                Data.english.description.part1

        descriptionPartTwo =
            if lang == "es" then
                Data.spanish.description.part2

            else
                Data.english.description.part2
    in
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
            (text aboutTitle)
        , paragraph [ Font.justify, spacing 10, padding 20 ]
            [ text descriptionPartOne
            , Data.workingAt
            , text descriptionPartTwo
            ]
        ]


abilities : Model -> Element Msg
abilities model =
    let
        skillsTitle =
            if model.lang == "es" then
                Data.spanish.skills

            else
                Data.english.skills
    in
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
                    (text skillsTitle)
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
                                (text "Programming")
                            , abilityProgress "PHP" IconsBrands.php (progressBar 8)
                            , abilityProgress "Ruby" IconsSolid.gem (progressBar 7)
                            , abilityProgress "JavaScript" IconsBrands.js (progressBar 7)
                            , abilityProgressImage "Elm" Data.images.elm (progressBar 6)
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
                            , abilityProgressImage "Ruby on Rails" Data.images.rails (progressBar 8)
                            , abilityProgress "Laravel" IconsBrands.laravel (progressBar 7)
                            , abilityProgress "React" IconsBrands.react (progressBar 7.5)
                            , abilityProgress "Vue" IconsBrands.vuejs (progressBar 6)
                            , abilityProgressImage "CodeIgniter" Data.images.ci (progressBar 6)
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
                                (text "OSes")
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
                    (text skillsTitle)
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
                                (text "Programming")
                            , abilityProgress "PHP" IconsBrands.php (progressBar 8)
                            , abilityProgress "JavaScript" IconsBrands.js (progressBar 7)
                            , abilityProgress "Ruby" IconsSolid.gem (progressBar 6)
                            , abilityProgressImage "Elm" Data.images.elm (progressBar 6)
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
                            , abilityProgressImage "Ruby on Rails" Data.images.rails (progressBar 8)
                            , abilityProgress "Laravel" IconsBrands.laravel (progressBar 7)
                            , abilityProgress "React" IconsBrands.react (progressBar 7.5)
                            , abilityProgress "Vue" IconsBrands.vuejs (progressBar 6)
                            , abilityProgressImage "CodeIgniter" Data.images.ci (progressBar 6)
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
                                (text "OSes")
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
    let
        projectsTitle =
            if model.lang == "es" then
                Data.spanish.projects

            else
                Data.english.projects
    in
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
                    (text projectsTitle)
                , commonProject "SAICyR" IconsBrands.php (my.git ++ "/SAICyR")
                , commonProject "Chami" IconsBrands.wordpress ""
                , commonProject "React-Calc" IconsBrands.react (my.ghPage ++ "calc-react")
                , commonProject "Herramientas" IconsBrands.php (my.git ++ "/sdgh")
                , commonProject "Recipes" IconsBrands.php ""
                , commonProject "RainPaste" IconsSolid.gem (my.git ++ "/rainpaste")
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
                        (text projectsTitle)
                    ]
                , row [ Element.spacingXY 20 0, centerX, centerY, width fill ]
                    [ commonProject "SAICyR" IconsBrands.php (my.git ++ "/SAICyR")
                    , commonProject "Chami" IconsBrands.wordpress ""
                    , commonProject "React-Calc" IconsBrands.react (my.ghPage ++ "calc-react")
                    ]
                , row [ Element.spacingXY 20 0, centerX, centerY, width fill ]
                    [ commonProject "Herramientas" IconsBrands.php (my.git ++ "/sdgh")
                    , commonProject "Recipes" IconsBrands.php ""
                    , commonProject "RainPaste" IconsSolid.gem (my.git ++ "/rainpaste")
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
    let
        servicesTitle =
            if model.lang == "es" then
                Data.spanish.services.title

            else
                Data.english.services.title

        webdev =
            if model.lang == "es" then
                Data.spanish.services.features.webdev

            else
                Data.english.services.features.webdev

        webdevDescription =
            if model.lang == "es" then
                Data.spanish.services.features.webdevDescription

            else
                Data.english.services.features.webdevDescription

        themes =
            if model.lang == "es" then
                Data.spanish.services.features.themes

            else
                Data.english.services.features.themes

        themesDescription =
            if model.lang == "es" then
                Data.spanish.services.features.themesDescription

            else
                Data.english.services.features.themesDescription

        shapeDevice =
            case model.device.class of
                Phone ->
                    [ Font.justify, spacing 10 ]

                _ ->
                    [ Font.justify, spacing 10, Element.paddingXY 40 20, Element.alignTop, centerX ]

        paragraphDesktop textDesc =
            case model.device.class of
                Phone ->
                    Element.none
                _ ->
                    paragraph [ centerX, Element.paddingXY 20 0 ]
                        [ text textDesc ]

    in
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
            (text servicesTitle)
        , column [ centerX ]
            [ Element.textColumn shapeDevice
                [ row
                    [ width fill
                    , Background.color Color.darkBg
                    , Border.rounded 6
                    , centerX
                    ]
                    [ commonProject webdev IconsSolid.code "#"
                    , paragraphDesktop webdevDescription
                    ]
                , row
                    [ width fill
                    , Background.color Color.darkBg
                    , Border.rounded 6
                    , centerX
                    ]
                    [ commonProject themes IconsSolid.eye "#"
                    , paragraphDesktop themesDescription
                    ]
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
                (text "Building...")
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
