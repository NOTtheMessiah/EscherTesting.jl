#! /usr/bin/env julia

using ArgParse
using Escher

include(Pkg.dir("Escher", "src", "cli", "serve.jl"))

python = ("/usr/bin/python2")
runPy = false
examples = ["form", "layout", "toolbar" ]

function startServer(port)
    println("serving $(Pkg.dir("Escher","examples"))")
    @async escher_serve(port,Pkg.dir("Escher","examples"))
end

function runTests(runPy)
    for ex in examples
        println("running test_$(ex).$(runPy ? "py":"jl")" )
        try run(`$(runPy ? python:"julia") test_$(ex).$(runPy ? "py":"jl")`)
        end
    end
end

parseCommandline() = begin
    s = ArgParseSettings(description = "This program runs Selenium tests on a list of Escher examples")
    @add_arg_table s begin
        "--py", "-y"
            help = "Run python version of tests"
            action = :store_true
        "--noserve", "-r"
            help = "Run tests without starting the server"
            action = :store_true
        "--port", "-p"
            help = "Port to run the HTTP server on"
            arg_type = Int
            default = 5555
    end
    parse_args(s)
end


function main() 
    parsedArgs = parseCommandline()
    if !parsedArgs["noserve"]
        escherServer = startServer(parsedArgs["port"])
    end
    runTests(parsedArgs["py"])
end

main()
