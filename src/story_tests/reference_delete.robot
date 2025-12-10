*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset Database And Go To Home Page

*** Test Cases ***
User Can Select All References And Delete Them
    [Documentation]  Test that user can select all references on the home page and delete them.
    Create Two References And Go To Home Page
    Home Page Should Be Open
    Page Should Contain  attention2017
    Page Should Contain  Refactoring

    Click Button  Valitse kaikki
    Click Button  Poista valitut
    Handle Alert  ACCEPT

    Wait Until Page Does Not Contain  attention2017
    Wait Until Page Does Not Contain  Refactoring
    Page Should Not Contain  attention2017
    Page Should Not Contain  Refactoring

User Can Delete Single Reference
    [Documentation]  Test that user can delete a single reference from the home page.
    Create Two References And Go To Home Page
    Home Page Should Be Open
    Page Should Contain  attention2017
    Page Should Contain  Refactoring

    Click Element  xpath=//a[contains(text(), 'attention2017')]/preceding-sibling::input[@type='checkbox']
    Click Button  Poista valitut
    Handle Alert  ACCEPT

    Wait Until Page Does Not Contain  attention2017
    Page Should Not Contain  attention2017
    Page Should Contain  Refactoring

User Can Cancel Deletion Of References
    [Documentation]  Test that user can cancel the deletion of selected references.
    Create Two References And Go To Home Page
    Home Page Should Be Open
    Page Should Contain  attention2017
    Page Should Contain  Refactoring

    Click Button  Valitse kaikki
    Click Button  Poista valitut
    Handle Alert  DISMISS

    Wait Until Page Contains  attention2017
    Wait Until Page Contains  Refactoring
    Page Should Contain  attention2017
    Page Should Contain  Refactoring




*** Keywords ***
Create Two References And Go To Home Page
    Create Article  attention2017  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is All You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Create Book  Refactoring  Martin Fowler, Kent Beck  Refactoring: Improving the Design of Existing Code  1999  Martin Fowler  Addison-Wesley Professional  Testimuistiinpanot
    Go To Home Page
