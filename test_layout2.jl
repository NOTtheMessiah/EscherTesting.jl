include("escherTesting.jl")

openPage("layout2.jl")
waitUntilElementLoads(:find_element_by_tag_name,"paper-icon-button",60)

facts("layout2.jl page contents") do

    mytabs = driver[:find_elements_by_tag_name]("paper-tab")
    context("Tabs exist") do
        @fact mytabs --> not([])
    end
    sleep(1)

    context("Check contents of menu below") do
        @fact driver[:find_element_by_tag_name]("iron-pages")[:find_element_by_css_selector]("div.iron-selected")[:text] --> "Hello, World!\nYou can write any Markdown text and place it in the middle of other tiles."
    end

    context("Click second tab and check") do
        mytabs[2][:click]()
        sleep(1)
        @fact driver[:find_element_by_tag_name]("iron-pages")[:text]-->"Notification tab content"
    end

    context("Click third tab and check") do
        mytabs[3][:click]()
        sleep(1)
        @fact driver[:find_element_by_tag_name]("iron-pages")[:text]-->"Settings tab content"
    end

end

driver[:quit]()
