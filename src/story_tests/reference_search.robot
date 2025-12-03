*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset Database And Go To Home Page

*** Test Cases ***
User Can Search Reference
    [Documentation]  Test that user can search for a reference by its name.
    Create Article Reference And Go To Home Page
    Home Page Should Be Open
    Input Text  name=query  attention
    Click Button  Hae
    Wait Until Page Contains  attention
    Page Should Contain  attention

Search Reference Should Return Correct Results
    [Documentation]  Test that searching for a reference returns correct results.
    Create Two References And Go To Home Page
    Home Page Should Be Open
    Input Text  name=query  attention
    Click Button  Hae
    Wait Until Page Contains  attention
    Page Should Not Contain  Refactoring


*** Keywords ***
Create Article Reference And Go To Home Page
    Create Article  attention2017  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is All You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Go To Home Page

Create Two References And Go To Home Page
    Create Article  attention2017  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is All You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Create Book  Refactoring  Martin Fowler, Kent Beck  Refactoring: Improving the Design of Existing Code  1999  Martin Fowler  Addison-Wesley Professional  Testimuistiinpanot
    Go To Home Page
    