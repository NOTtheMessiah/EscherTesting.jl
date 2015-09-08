# EscherTesting.jl
Selenium Test scripts and Utilities for Escher.jl


##### Requirements 

* [Selenium Server Standalone](http://seleniumhq.org/)
* [Python binding for Selenium Remote Control](http://pypi.python.org/pypi/selenium)
* Web Browser with a WebDriver implementation (defaults to [Chromium](http://www.chromium.org/))
* Julia packages: Escher, Compat, [PyCall](https://github.com/stevengj/PyCall.jl)

##### Project structure

for each  ```$(JULIADIR)/example/<name>.jl``` there should be an associated ```test_<name>.py``` and ```test_<name>.jl```.  Each contains several tests cases corresponding to the example.

```runtests.jl``` will start a server and run each test file indepently. You may run the python test with the command-line option --py, 

Tests are currently Chrome-only, and the Julia version uses PyCall

##### Command line options

```
usage: runtests.jl [-y] [-s] [-p PORT] [-h] [files...]

positional arguments:
  files            list of files to run tests on, will look for
                   run_<filename>.jl in current dir for each test
                   (default: ASCIIString["form","layout","toolbar"])

optional arguments:
  -y, --py         Run python version of tests
  -s, --serve      Serve examples folder before running tests
  -d, --driver     Driver (Browser) to use. (case-sensitive) (type: String)
  -p, --port PORT  Port to run the HTTP server on (type: Int64,
                   default: 5555)
  -h, --help       show this help message and exit
```

##### Roadmap

* Beautify output (via terminal colors or FactCheck.jl)
* If necessary, create Julia selenium bindings to WebDriver.
* modularize julia tests so exception don't stop the script from running

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
* toolbar.jl
  - Check existence of tabs
  - Click on tabs and check update

### Incomplete 
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


