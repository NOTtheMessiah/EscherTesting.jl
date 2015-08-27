using Escher

include(Pkg.dir("Escher", "src", "cli", "serve.jl"))

println(VERSION)
python = ("/usr/bin/python2")
examples = ["form", "layout", "toolbar" ]
juliaDir = string(homedir(), "/.julia/v", VERSION.major, ".", VERSION.minor, )

function main() 
	println("serving $(juliaDir)/Escher/examples")
	escherServer = @async escher_serve(5555,"$(juliaDir)/Escher/examples")
	for ex in examples
		println("running test_$(ex).py" )
		run(`$(python) test_$(ex).py`)
	end
end
