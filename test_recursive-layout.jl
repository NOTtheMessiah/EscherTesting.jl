include("escherTesting.jl")

openPage("recursive-layout.jl")

waitUntilElementLoads(:find_element_by_css_selector,"div.flow:nth-child(1)",60)

facts("recursive-layout.jl dimensions") do

    context("outer box: width == height") do
        local a = driver[:find_element_by_css_selector]("div.flow.vertical")[:size]
        println("The dimensions of the outer box: ", a["height"]," ",a["width"])
        @fact a["height"] --> a["width"]
    end

    context("first box: width/2 ≈ height") do
        local a = driver[:find_element_by_css_selector]("div.flow.vertical > div")[:size]
        println("height and width of first block in the sequence: ", a["height"]," * 2 ≈ ",a["width"])
        @fact abs(a["height"] - a["width"]/2) --> less_than(2)
    end

end

driver[:quit]()
