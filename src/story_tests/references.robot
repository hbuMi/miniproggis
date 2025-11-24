*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset Database And Go To Home Page

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

User Can View Book Reference Details
    Create Book Reference And Go To Home Page
    Home Page Should Be Open
    Page Should Contain  Refactoring
    Click Link  Refactoring
    Location Should Contain  /reference/
    Title Should Be  Lähde
    Page Should Contain  Refactoring: Improving the Design of Existing Code
    Page Should Contain  Martin Fowler, Kent Beck
    Page Should Contain  Addison-Wesley Professional
    Page Should Contain  1999
    Page Should Contain  Testimuistiinpanot


*** Keywords ***
Create Book Reference And Go To Home Page
    Create Book  Refactoring  Martin Fowler, Kent Beck  Refactoring: Improving the Design of Existing Code  1999  Martin Fowler  Addison-Wesley Professional  Testimuistiinpanot
    Go To Home Page


