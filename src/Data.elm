module Data exposing (..)

import Element exposing (newTabLink, text)
import Element.Font as Font


-- Static Data


protocol =
    { mail = "mailto://"
    , link = "https://"
    }



-- Personal Info


workingAt =
    Element.newTabLink [ Font.underline ]
        { url = "https://ereditadigital.com"
        , label = text "Eredità Digital"
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



-- Translations

type alias Translatable =
    { -- Titles
      main : String
    , about : String

    -- About me Content
    , description :
        { part1 : String
        , part2 : String
        }
    , projects : String
    , skills : String
    , services :
        { title : String
        , features :
            { themes : String
            , themesDescription : String
            , webdev : String
            , webdevDescription : String
            }
        }
    , contact : String
    }

spanish : Translatable
spanish =
    { main = "Portafolio"
    , about = "Sobre mí"
    , projects = "Proyectos"
    , skills = "Habilidades"
    , services =
        { title = "Servicios"
        , features =
            { webdev = "Desarrollo Web"
            , webdevDescription = """He desarrollado en varios frameworks web,
                                   especialmente en PHP y Ruby en cuanto al backend,
                                   en el frontend me he desenvuelto en React, Vue y
                                   mi favorito Elm"""
            , themes = "Creación de Temas"
            , themesDescription = """He trabajado para una empresa que se dedicaba hacer temas
                                   Wordpress, en la actualidad hice algunos temas para Omeka
                                   y he usado algunas veces Opencart"""
            }
        }
    , contact = "Contacto"
    , description =
        { part1 = """Soy un estudiante universitario de informática
                        culminando mi carrera, la cual disfruto mucho
                        por lo cual siempre amplio mis horizontes en la
                        informatica, ya que tengo muchos campos de
                        intereses relacionados a ella, desde el
                        desarrollo web hasta el de videojuegos, ultimamente
                        dedicandome más a lo primero, trabajo en """
        , part2 = """ como administrador de sistemas y soy freelancer
                        en mi tiempo libre, es por esa razón tomo mi
                        trabajo como algo personal, “Hacer lo que amo
                        y amar lo que hago” siento que esa frase es
                        importante para un programador, por esa razón
                        me gusta enfrentarme a nuevos desafíos
                        constantemente, siempre tomando en cuenta mi afán
                        por el Software Libre y a los Sistemas Operativos
                        tipo UNIX mientras lo hago."""
        }
    }


english : Translatable
english =
    { main = "Portfolio"
    , about = "About me"
    , projects = "Projects"
    , skills = "Skills"
    , services =
        { title = "Services"
        , features =
            { webdev = "Web Development"
            , webdevDescription = """I have developing in several web frameworks,
                                   especially on PHP and Ruby in the backend,
                                   in the frontend i have experience in React, Vue and
                                   my favorite Elm"""
            , themes = "Themes Creation"
            , themesDescription = """I worked for a little company of design especialized in
                                   themes for wordpress, although currently i made
                                   several themes for Omeka and i have used
                                   sometimes Opencart"""
            }
        }
    , contact = "Contact"
    , description =
        { part1 = """I am a venezolan college student in Computer Sciences
                       finishing my career, which enjoy a lot studying it
                       constantly  because i have many interests in those
                       fields, from Web development until videogames development,
                       althought ultimately i dedicate more time at first of them,
                       besides I am work in """
        , part2 = """ and I am freelancer in my freetime, simply “Doing what i love
                       it and loving what i do it” actually expressing something important
                       to me, since i like learn new techs and programming languages, so i
                       think that the curiosity it's a weapon for any programmer, and it's
                       the reason because i've never stop to learning and i advocate the
                       Open Source and Free Software, plus of i love UNIX-like Operating
                       Systems."""
        }
    }



-- Helper Data


progressBar : Float -> String
progressBar points =
    String.repeat (ceiling points) "█"
        ++ String.repeat (10 - ceiling points) "░"
        ++ "    "
        ++ String.fromFloat (points / 10 * 100)
        ++ "%"
