using PyCall
using Base.Test

@pyimport selenium.webdriver as webdriver

if !isdefined(:driver)
    "Android" in ARGS ? driver = webdriver.Android() :
    "Edge" in ARGS ? driver = webdriver.Edge() :
    "Firefox" in ARGS ? driver = webdriver.Firefox() :
    "Ie" in ARGS ? driver = webdriver.Ie() :
    "Opera" in ARGS ? driver = webdriver.Opera() :
    "PhantomJS" in ARGS ? driver = webdriver.PhantomJS() :
    "Safari" in ARGS ? driver = webdriver.Safari() :
        driver = webdriver.Chrome()
end

serverAddress = "http://localhost:5555/"

openPage(s) = driver[:get]("$(serverAddress)$(s)")

function waitUntilElementLoads(how::Symbol,element::String,patience::Int) 
    for i=1:patience
        try 
            a = driver[how](element)
            if isa(a,PyCall.PyObject)
                println("TIME: took ~$i seconds to find reference element")
                break
            end
            catch sleep(1)
        end
    end
end
