*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset Database And Go To Home Page

*** Test Cases ***
User Can Search Reference By Name
    [Documentation]  Test that user can search for a reference by its name.
    Create Article Reference And Go To Home Page
    Home Page Should Be Open
    Input Text  name=query  attention
    Click Button  Hae
    Wait Until Page Contains  Attention Is All You Need
    Page Should Contain  Attention Is All You Need

Search Reference By Name Should Return Correct Results
    [Documentation]  Test that searching for a reference by name returns correct results.
    Create Two References And Go To Home Page
    Home Page Should Be Open
    Input Text  name=query  attention
    Click Button  Hae
    Wait Until Page Contains  Attention Is All You Need
    Page Should Not Contain  Refactoring

User Can Search Reference By Author
    [Documentation]  Test that user can search for a reference by its author.
    Create Article Reference And Go To Home Page
    Home Page Should Be Open
    Input Text  name=author  Vaswani
    Click Button  Hae
    Wait Until Page Contains  Attention Is All You Need
    Page Should Contain  Attention Is All You Need

Search Reference By Author Should Return Correct Results
    [Documentation]  Test that searching for a reference by author returns correct results.
    Create Two References And Go To Home Page
    Home Page Should Be Open
    Input Text  name=author  Vaswani
    Click Button  Hae
    Wait Until Page Contains  Attention Is All You Need
    Page Should Not Contain  Refactoring

User Can Search Reference By Exact Year
    [Documentation]  Test that user can search for a reference by its exact year.
    Create Article Reference And Go To Home Page
    Home Page Should Be Open
    Input Text  name=mindate  2017
    Input Text  name=maxdate  2017
    Click Button  Hae
    Wait Until Page Contains  Attention Is All You Need
    Page Should Contain  Attention Is All You Need

User Can Search Reference By Year Range
    [Documentation]  Test that user can search for a reference by a range of years.
    Create Two References And Go To Home Page
    Home Page Should Be Open
    Input Text  name=mindate  1990
    Input Text  name=maxdate  2020
    Click Button  Hae
    Wait Until Page Contains  Attention Is All You Need
    Wait Until Page Contains  Refactoring

*** Keywords ***
Create Article Reference And Go To Home Page
    Create Article  attention2017  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is All You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Go To Home Page

Create Two References And Go To Home Page
    Create Article  attention2017  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is All You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Create Book  Refactoring  Martin Fowler, Kent Beck  Refactoring: Improving the Design of Existing Code  1999  Martin Fowler  Addison-Wesley Professional  Testimuistiinpanot
    Go To Home Page
