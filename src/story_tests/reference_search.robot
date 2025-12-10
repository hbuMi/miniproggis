*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset Database And Go To Home Page

*** Test Cases ***
User Can Search Reference By Title
    [Documentation]  Test that user can search for a reference by its title.
    Create Article Reference And Go To Home Page
    Home Page Should Be Open
    Input Text  name=query  attention
    Click Button  Hae
    Wait Until Page Contains  Attention Is All You Need
    Page Should Contain  Attention Is All You Need

Search Reference By Title Should Return Correct Results
    [Documentation]  Test that searching for a reference by title returns correct results.
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

Search Reference By Year Should Return Correct Results
    [Documentation]  Test that searching for a reference by year returns correct results.
    Create Two References And Go To Home Page
    Home Page Should Be Open
    Input Text  name=mindate  1999
    Input Text  name=maxdate  1999
    Click Button  Hae
    Wait Until Page Contains  Refactoring
    Page Should Contain  Refactoring

Search Reference By Year Range Should Return Correct Results
    [Documentation]  Test that searching for a reference by a range of years returns correct results.
    Create Two References And Go To Home Page
    Home Page Should Be Open
    Input Text  name=mindate  1990
    Input Text  name=maxdate  2000
    Click Button  Hae
    Wait Until Page Contains  Refactoring
    Page Should Not Contain  Attention Is All You Need

Search Reference By Title Author And Year Should Return Correct Results
    [Documentation]  Test that searching for a reference with title, author and year filled returns correct results.
    Create One Search Result Reference And Three Dummy References And Go To Home Page
    Home Page Should Be Open
    Input Text  name=query  attention
    Input Text  name=author  Vaswani
    Input Text  name=mindate  2017
    Input Text  name=maxdate  2017
    Click Button  Hae
    Wait Until Page Contains  Attention Is All You Need
    Page Should Not Contain  Attention Is All You Neeed
    Page Should Not Contain  Attention Is Aall You Need
    Page Should Not Contain  That Is All You Need


*** Keywords ***
Create Article Reference And Go To Home Page
    Create Article  attention2017  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is All You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Go To Home Page

Create Two References And Go To Home Page
    Create Article  attention2017  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is All You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Create Book  Refactoring  Martin Fowler, Kent Beck  Refactoring: Improving the Design of Existing Code  1999  Martin Fowler  Addison-Wesley Professional  Testimuistiinpanot
    Go To Home Page

Create One Search Result Reference And Three Dummy References And Go To Home Page
    Create Article  attention2017  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is All You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Create Article  attentionDummy1  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is All You Neeed  2020  Advances in Neural Information Processing Systems  Testiartikkeli
    Create Article  attentionDummy2  Ashish Vaswanni, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is Aall You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Create Article  attentionDummy3  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  That Is All You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Go To Home Page
