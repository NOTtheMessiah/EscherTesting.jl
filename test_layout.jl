include("escherTesting.jl")

openPage("layout.jl")

waitUntilElementLoads(:find_element_by_css_selector,"div.flow:nth-child(1)",60)

let
    local a = driver[:find_element_by_css_selector]("div.flow.vertical")[:size]
    println("The dimensions of the outer box: ", a["height"]," ",a["width"])
    @test a["height"] == a["width"]
end


let
    local a = driver[:find_element_by_css_selector]("div.flow.vertical > div")[:size]
    println("height and width of first block in the sequence: ", a["height"]," * 2 ≈ ",a["width"])
    @test abs(a["height"] - a["width"]/2) < 2
end

driver[:quit]()
