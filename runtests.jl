using Escher

include(Pkg.dir("Escher", "src", "cli", "serve.jl"))

python = ("/usr/bin/python2")
runPy = true 

examples = ["form", "layout", "toolbar" ]

function main() 
    println("serving $(Pkg.dir())/Escher/examples")
    escherServer = @async escher_serve(5555,Pkg.dir("Escher","examples"))
    for ex in examples
        println("running test_$(ex).$(runPy ? "py":"jl")" )
        try run(`$(runPy ? "python2":"julia") test_$(ex).$(runPy ? "py":"jl")`)
        end
    end
end
