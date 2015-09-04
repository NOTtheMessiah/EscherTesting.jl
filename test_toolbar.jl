include("escherTesting.jl")

openPage("toolbar.jl")
waitUntilElementLoads(:find_element_by_tag_name,"paper-icon-button",60)

# Tabs exist
mytabs = driver[:find_elements_by_tag_name]("paper-tab")
@test mytabs != []
sleep(1)

# Check contents of menu below
@test driver[:find_element_by_tag_name]("iron-pages")[:find_element_by_css_selector]("div.iron-selected")[:text]=="Hello, World!\nYou can write any Markdown text and place it in the middle of other tiles."

# Click second tab
mytabs[2][:click]()
sleep(1)
@test driver[:find_element_by_tag_name]("iron-pages")[:text]=="b"

# Click third tab
mytabs[3][:click]()
sleep(1)
@test driver[:find_element_by_tag_name]("iron-pages")[:text]=="c"

driver[:quit]()
