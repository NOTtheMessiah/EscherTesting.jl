include("escherTesting.jl")

openPage("plotting.jl")

waitUntilElementLoads(:find_element_by_xpath,"//div[2]/div/div[1]/h1",60)

facts("plots do things") do

    context("page loads") do
        sleep(1)
        @fact driver[:find_element_by_xpath]("//div[2]/div/div[1]/h1")[:text] --> "Static Plot"
        @fact driver[:find_element_by_css_selector]("g:nth-child(4) > g > g > text:nth-child(1)")[:text] --> "-1.0"
    end
    context("slider changes y axis") do
        a = driver[:find_element_by_css_selector]("div:nth-child(2) > div > div:nth-child(4) > paper-slider")
        driver[:execute_script]("document.getElementsByTagName('paper-slider')[0].value=100")
        myknob = driver[:find_element_by_id]("sliderKnob")
        sleep(0.2)
        action_chain = webdriver.ActionChains(driver)
        action_chain[:drag_and_drop_by_offset](myknob,40,0)[:perform]()
        sleep(2.5)
        @fact driver[:find_element_by_css_selector]("div:nth-child(2) > div > signal-container > div.graphic-wrap > svg > g > g > g > g:nth-child(4) > g > g > text:nth-child(2)")[:text] --> "50"
    end

end

driver[:quit]()
