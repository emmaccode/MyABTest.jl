module MyABTest
using Toolips
using ToolipsSession

global A = 0
global B = 0
global A_UN = 0
global B_UN = 0
# welcome to your new toolips project!
"""
home(c::Connection) -> _
--------------------
The home function is served as a route inside of your server by default. To
    change this, view the start method below.
"""
function home(c::Connection)
    selected = rand(1:2)
    if selected == 1
        main = body("mainbod", align = "center")
        newbut = button("newbutA", text = "enter website")
        style!(main, "padding" => 20px, "background-color" => "lightblue")
        push!(main, newbut)
        on(c, "unload") do cm::ComponentModifier
            global A_UN += 1
        end
        on(c, newbut, "click") do cm::ComponentModifier
            global A += 1
            set_children!(cm, main, Vector{Servable}([h("label", 1, text = "$A")]))
        end
        write!(c, main)
        return
    end
    on(c, "unload") do cm::ComponentModifier
        global B_UN += 1
    end
    main = body("mainbod", align = "center")
    style!(main, "cbackground-olor" => "orange")
    newbut = button("newbutB", text = "enter website")
    on(c, newbut, "click") do cm::ComponentModifier
        global B += 1
        set_children!(cm, main, Vector{Servable}([h("label", 1, text = "$B")]))
    end
    style!(main, "padding" => 20px, "background-color" => "pink")
    push!(main, newbut)
    write!(c, main)
end

fourofour = route("404") do c
    write!(c, p("404message", text = "404, not found!"))
end

routes = [route("/", home), fourofour]
extensions = Vector{ServerExtension}([Logger(), Files(), Session(), ])
"""
start(IP::String, PORT::Integer, ) -> ::ToolipsServer
--------------------
The start function starts the WebServer.
"""
function start(IP::String = "127.0.0.1", PORT::Integer = 8000)
     ws = WebServer(IP, PORT, routes = routes, extensions = extensions)
     ws.start(); ws
end
end # - module
