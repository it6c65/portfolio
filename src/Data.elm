module Data exposing (..)

import Element exposing (newTabLink, text)
import Element.Font as Font



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


progressBar : Float -> String
progressBar points =
    String.repeat (ceiling points) "█"
        ++ String.repeat (10 - ceiling points) "░"
        ++ "    "
        ++ String.fromFloat (points / 10 * 100)
        ++ "%"


workingAt =
    Element.newTabLink [ Font.underline ]
        { url = "https://ereditadigital.com"
        , label = text "Eredità Digital"
        }


aboutTitle =
    { spanish = text "Sobre mí"
    , english = text "About me"
    }



-- NEED refactoring this data structure


aboutDescription =
    { -- In Spanish
      spanish1 =
        text """Soy un estudiante universitario de informática
                        culminando mi carrera, la cual disfruto mucho
                        por lo cual siempre amplio mis horizontes en la
                        informatica, ya que tengo muchos campos de
                        intereses relacionados a ella, desde el
                        desarrollo web hasta el de videojuegos, ultimamente
                        dedicandome más a lo primero, trabajo en """
    , spanish2 =
        text """ como administrador de sistemas y soy freelancer
                        en mi tiempo libre, es por esa razón tomo mi
                        trabajo como algo personal, “Hacer lo que amo
                        y amar lo que hago” siento que esa frase es
                        importante para un programador, por esa razón
                        me gusta enfrentarme a nuevos desafíos
                        constantemente, siempre tomando en cuenta mi afán
                        por el Software Libre y a los Sistemas Operativos
                        tipo UNIX mientras lo hago."""
    , -- In English
      english1 =
        text """I am a venezolan college student in Computer Sciences
                       finishing my career, which enjoy a lot studying it
                       constantly  because i have many interests in those
                       fields, from Web development until videogames development, althought
                       ultimately i dedicate more time at first of them, besides I am work in """
    , english2 =
        text """ and I am freelancer in my freetime,
                    simply “Doing what i love it and loving what i do it”
                    actually expressing something important to me, since
                    i like learn new techs and programming languages,
                    so i think that the curiosity it's a
                    weapon for any programmer, and it's the reason because
                    i've never stop to learning and i advocate the Open Source
                    and Free Software, plus of i love UNIX-like Operating Systems."""
    }
