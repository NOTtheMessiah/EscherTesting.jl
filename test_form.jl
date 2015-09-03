include("escherTesting.jl")

using Escher.LeftButton

using Compat

openPage("form.jl")

waitUntilElementLoads(:find_element_by_css_selector,"div.flow.vertical  > span",60)
sleep(1)

# Check if result is empty
@test eval(parse( driver[:find_element_by_css_selector]("div.flow.vertical  > span")[:text] )) == @compat Dict{Any,Any}()
sleep(1)

# Set rating to 5 and submit
myslider = driver[:find_element_by_tag_name]("paper-slider")
driver[:execute_script]("document.getElementsByTagName('paper-slider')[0].value=5")
driver[:find_element_by_tag_name]("paper-button")[:click]()
sleep(2)
@test eval(parse( driver[:find_element_by_css_selector]("div.flow.vertical  > span")[:text] )) == @compat Dict{Any,Any}(:submit=>Escher.LeftButton(),:name=>"",:_trigger=>:submit,:rating=>5)

# Set name and submit
driver[:execute_script]("document.getElementsByTagName('paper-slider')[0].value=1")
myname = driver[:find_element_by_id]("input")
myname[:clear]()
myname[:send_keys]("John Nada")
driver[:find_element_by_tag_name]("paper-button")[:click]()
@test eval(parse( driver[:find_element_by_css_selector]("div.flow.vertical  > span")[:text] )) == @compat Dict{Any,Any}(:submit=>Escher.LeftButton(),:name=>"John Nada",:_trigger=>:submit,:rating=>1)

driver[:quit]()
