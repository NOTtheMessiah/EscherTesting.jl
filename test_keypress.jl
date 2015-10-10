include("escherTesting.jl")

openPage("keypress.jl")

waitUntilElementLoads(:find_element_by_xpath,"//div[2]",60)

facts("pressing keys are heard") do

    context("page loads") do
        sleep(1)
        @fact driver[:find_element_by_xpath]("//div[2]")[:text] --> "Focus and press w, a, s, d or arrow keys\nEscher.Key(\"\",false,false,false,false)"
    end
    context("press a") do
        a = driver[:find_element_by_xpath]("//div[2]")
        sleep(0.2)
        a[:click]()
        sleep(0.2)
        a[:send_keys]("a")
        sleep(0.2)
        @fact a[:text] --> "Focus and press w, a, s, d or arrow keys\nEscher.Key(\"a\",false,false,false,false)"
    end

end

driver[:quit]()
