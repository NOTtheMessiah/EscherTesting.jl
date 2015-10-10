#! /usr/bin/env julia

using ArgParse
using Requires
if !( "--help" in ARGS || "-h" in ARGS )
    using Escher
    if ( "--xvfb" in ARGS || "-x" in ARGS )
        using XvfbWrapper
    end

    include(Pkg.dir("Escher", "src", "cli", "serve.jl"))
end


function startServer(port)
    println("serving $(Pkg.dir("Escher","examples"))")
    @async escher_serve(port,Pkg.dir("Escher","examples"))
end

function runTests(examples,driver="Chrome",runPy=false)
    for ex in examples
        println("running test_$(ex).$(runPy ? "py":"jl")" )
        if runPy
            try run(`python2 test_$(ex).py`)
            end
        else
            try run(`julia --color=yes test_$(ex).jl $(driver)`)
            end
        end
    end
end

parseCommandline() = begin
    s = ArgParseSettings(description = "This program runs Selenium tests on a list of Escher examples")
    @add_arg_table s begin
        "--xvfb", "-x"
            help = "Run browser in a virtual framebuffer (Requires XvfbWrapper.jl)"
            action = :store_true
        "--py", "-y"
            help = "Run python version of tests"
            action = :store_true
        "--serve", "-s"
            help = "Serve examples folder before running tests"
            action = :store_true
        "--driver", "-d"
            help = "Driver (Browser) to use, case-sensitive"
            arg_type = AbstractString
            default = "Chrome"
        "--port", "-p"
            help = "Port to run the HTTP server on"
            arg_type = Int
            default = 5555
        "files"
            help = "list of files to run tests on, will look for run_<filename>.jl in current dir for each test"
            nargs = '*'
            arg_type = AbstractString
            default = ["form", "recursive-layout", "layout2", "minesweeper", "plotting", "keypress", "vectorgraphics"]
    end
    parse_args(s)
end


function main() 
    parsedArgs = parseCommandline()
    # @require XvfbWrapper begin
    if parsedArgs["xvfb"] 
        fb = Xvfb()
        start!(fb)
    end
    # end
    if parsedArgs["serve"]
        escherServer = startServer(parsedArgs["port"])
    end
    runTests(parsedArgs["files"],parsedArgs["driver"],parsedArgs["py"])
    if parsedArgs["xvfb"] stop!(fb) end
end

main()
