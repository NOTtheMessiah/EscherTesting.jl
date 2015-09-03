using PyCall
using Base.Test

@pyimport selenium.webdriver as webdriver

driver = webdriver.Chrome()

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
