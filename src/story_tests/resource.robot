*** Settings ***
Library  SeleniumLibrary
Library  ../repositories/reference_repository.py

*** Variables ***
${SERVER}     localhost:5001/
${DELAY}      0.5 seconds
${HOME_URL}   http://${SERVER}
${RESET_URL}  http://${SERVER}/reset_db
${BROWSER}    chrome
${HEADLESS}   false

*** Keywords ***
Open And Configure Browser
    IF  $BROWSER == 'chrome'
        ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
        Call Method  ${options}  add_argument  --incognito
    ELSE IF  $BROWSER == 'firefox'
        ${options}  Evaluate  sys.modules['selenium.webdriver'].FirefoxOptions()  sys
        Call Method  ${options}  add_argument  --private-window
    END
    IF  $HEADLESS == 'true'
        Set Selenium Speed  0.01 seconds
        Call Method  ${options}  add_argument  --headless
    ELSE
        Set Selenium Speed  ${DELAY}
    END
    Open Browser  browser=${BROWSER}  options=${options}

Go To Home Page
    Go To  ${HOME_URL}

Go To Create New Reference Page
    Go To  ${HOME_URL}/new_reference

Reset References
    Go To  ${RESET_URL}

Reset References And Go To Home Page
    Reset References
    Go To Home Page

Home Page Should Be Open
    Location Should Be  ${HOME_URL}
    Title Should Be  BibTextittäjä 3000

Create New Reference Page Should Be Open
    Location Should Be  ${HOME_URL}/new_reference
    Title Should Be  Lisää Lähde


