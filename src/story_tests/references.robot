*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References And Go To Home Page

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
    Create Book Reference Should Succeed With Message  Lähde lisätty!
    Page Should Contain  Clean Code

User Can View Reference List On Home Page
    Home Page Should Be Open
    Create Book Reference
    Page Should Contain  Clean Code

User Can View Book BibTeX Page
    Home Page Should Be Open
    Click Link  Clean Code
    Page Should Contain  @book
    Page Should Contain  title = Clean Code: A Handbook of Agile Software Craftsmanship
    Page Should Contain  author = Robert C. Martin
    Page Should Contain  publisher = Addison-Wesley Professional
    Page Should Contain  year = 2008
    Page Should Contain  note = Testikommentti

*** Keywords ***
Create Book Reference Should Succeed With Message
    [Arguments]  ${message}
    Create New Reference Page Should Be Open
    Page Should Contain  ${message}

Create Book Reference
    Create Book  Clean Code  Robert C. Martin  Robert C. Martin  Clean Code: A Handbook of Agile Software Craftsmanship  Addison-Wesley Professoinal  2008  Testikommentti

BibTeX Page Should Be Open For Reference
    [Arguments]  ${reference_id}
    Location Should Be  ${HOME_URL}/reference/${reference_id}
