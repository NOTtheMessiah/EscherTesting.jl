# EscherTesting.jl
Selenium Test scripts and Utilities for Escher.jl


##### Requirements 

* [Selenium Server Standalone](http://seleniumhq.org/)
* [Python binding for Selenium Remote Control](http://pypi.python.org/pypi/selenium)
* Web Browser with a WebDriver implementation (defaults to [Chromium](http://www.chromium.org/))

##### Project structure

for each  ```$(JULIADIR)/example/<name>.jl``` there should be an associated ```test_<name>.py```.  Each contains independent tests cases 
Initially, tests will be in Python and Chrome-only, but will be ported to either use PyCall or call WebDriver directly within Julia, and will be cross-platform (in that you can choose which browser to run the tests in from the command line).

##### Cross-platform tests

For use of Firefox or Safari (or any other supported browser), replace ```driver = webdriver.Chrome()``` with the respective webdriver. As of now, Firefox has limited support for WebComponents, as the polyfills are not complete. 

# Test Cases
Each test file will perform independent tests via the python unittest module.

### Completed
* form.jl 
  - Input name and check
  - Input rating and check
* layout.jl
  - Check if the first vertical flow is square (height == width)
### Future
* minesweeper.jl
  - inject game board state via JS, and check clicking
* tex.jl
  - Check to see if it outputs TeX

# External References

##### Escher

* https://shashi.github.io/Escher.jl/reactive.html
* https://github.com/shashi/Patchwork.jl
* https://github.com/JuliaLang/Reactive.jl

##### Selenium

* https://seleniumhq.github.io/selenium/docs/api/py/index.html
* https://selenium-python.readthedocs.org/en/latest/index.html
* https://github.com/SeleniumHQ/selenium/tree/master/py

##### Polymer

* https://www.polymer-project.org/0.5/docs/start/getting-the-code.html
* https://github.com/Polymer/web-component-testre

##### Shadow DOM

* introduction: http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/
* proposal: https://w3c.github.io/webcomponents/spec/shadow/


