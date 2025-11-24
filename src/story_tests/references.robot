*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Go To Home Page

*** Test Cases ***
User Can Add Book Reference
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Input Text  name        Clean Code
    Input Text  author      Robert C. Martin
    Input Text  editor      Robert C. Martin
    Input Text  title       Clean Code: A Handbook of Agile Software Craftsmanship
    Input Text  publisher   Addison-Wesley Professional
    Input Text  year        2008
    Input Text  note        Testikommentti
    Click Button  Lisää Lähde
    Wait Until Location Is  ${HOME_URL}/
    Home Page Should Be Open
    Page Should Contain  Clean Code

*** Keywords ***
