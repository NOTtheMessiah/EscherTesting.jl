include("escherTesting.jl")

openPage("vectorgraphics.jl")

waitUntilElementLoads(:find_element_by_css_selector,"svg",60)

@pyimport selenium

facts("vector graphics renders") do

    context("page loads and triangle exists") do
        sleep(1)
        @fact driver[:find_element_by_css_selector]("svg > g > path")[:get_attribute]("d") --> "M141.42,100 L 0 100 70.71 0 z"
    end
    context("set iterations to 1 and count the triangles") do
        myslider = driver[:find_element_by_tag_name]("paper-slider")
        driver[:execute_script]("document.getElementsByTagName('paper-slider')[0].value=1")
        myknob = driver[:find_element_by_id]("sliderKnob")
        action_chain = webdriver.ActionChains(driver)
        action_chain[:drag_and_drop_by_offset](myknob,40,0)[:perform]()
        sleep(0.3)
        @fact driver[:find_elements_by_css_selector]("svg > g > g") |> length --> 3
    end

end

driver[:quit]()
