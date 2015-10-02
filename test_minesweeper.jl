include("escherTesting.jl")

openPage("minesweeper.jl")

waitUntilElementLoads(:find_element_by_xpath,"//div[2]/div/paper-material/div",60)

facts("minesweeper.jl is playable") do

    context("find a bomb, game over") do
        for i = 1:10, j = 1:10
            println("    playing $i x $j")
            driver[:find_element_by_xpath]("//div[$(i)]/div[$(j)]/paper-material/div")[:click]()
            sleep(0.2)
            if driver[:find_element_by_xpath]("//div[$(i)]/div[$(j)]/paper-material/div")[:text] == ""
                println("    BOOM!")
                @fact driver[:find_element_by_tag_name]("paper-button")[:text] --> "START AGAIN"
                driver[:find_element_by_tag_name]("paper-button")[:click]()
                break
            end
        end
    end

    context("board is clear") do
        sleep(0.7)
        @fact driver[:find_element_by_xpath]("//div[1]/div/paper-material/div/span")[:text] --> ""
    end

end

driver[:quit]()
