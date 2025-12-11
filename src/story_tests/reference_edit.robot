*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset Database And Go To Home Page


*** Test Cases ***
User Can Open Article Reference Edit Page
    [Documentation]  Test that user can open the reference edit page from the home page.
    Create Article Reference And Go To Home Page
    Home Page Should Be Open
    Click Link  attention2017
    Wait Until Page Contains  Attention Is All You Need
    Wait Until Page Contains Element  xpath=//a[contains(text(),'Muokkaa lähdettä')]
    ${ref_url}=  Get Location
    Click Link  Muokkaa lähdettä
    Wait Until Location Is  ${ref_url}/edit
    Title Should Be  Muokkaa lähdettä

    Page Should Contain Element  name=name
    Page Should Contain Element  name=author
    Page Should Contain Element  name=title
    Page Should Contain Element  name=year
    Page Should Contain Element  name=journal
    Page Should Contain Element  name=note

Edit Article Reference Form Should Autofill Correct Values
    [Documentation]  Test that the reference edit form contains the correct values for an article reference.
    Create Article Reference And Go To Home Page
    Home Page Should Be Open
    Click Link  attention2017
    Wait Until Page Contains  Attention Is All You Need
    Wait Until Page Contains Element  xpath=//a[contains(text(),'Muokkaa lähdettä')]
    Click Link  Muokkaa lähdettä
    Title Should Be  Muokkaa lähdettä

    Textfield Value Should Be  name=name  attention2017
    Textfield Value Should Be  name=author  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin
    Textfield Value Should Be  name=title  Attention Is All You Need
    Textfield Value Should Be  name=year  2017
    Textfield Value Should Be  name=journal  Advances in Neural Information Processing Systems
    Textfield Value Should Be  name=note  Testiartikkeli

User Can Edit Article Reference And See Changes On Reference Page
    [Documentation]  Test that user can edit an article reference and see the changes on the reference page.
    Create Article Reference And Go To Home Page
    Home Page Should Be Open
    Click Link  attention2017
    Wait Until Page Contains  Attention Is All You Need
    Wait Until Page Contains Element  xpath=//a[contains(text(),'Muokkaa lähdettä')]
    ${ref_url}=  Get Location
    Click Link  Muokkaa lähdettä
    Wait Until Location Is  ${ref_url}/edit
    Title Should Be  Muokkaa lähdettä

    Input Text  name=name  EditedAttention2024
    Input Text  name=author  Edited Author
    Input Text  name=title  Edited Title
    Input Text  name=year  2024
    Input Text  name=journal  Edited Journal
    Input Text  name=note  Edited Note

    Click Button  Tallenna muutokset
    Wait Until Location Is  ${ref_url}

    Page Should Contain  EditedAttention2024
    Page Should Contain  Edited Author
    Page Should Contain  Edited Title
    Page Should Contain  2024
    Page Should Contain  Edited Journal
    Page Should Contain  Edited Note

User Can Open Book Reference Edit Page
    [Documentation]  Test that user can open the book reference edit page from the home page.
    Create Book Reference And Go To Home Page
    Home Page Should Be Open
    Click Link  Refactoring
    Wait Until Page Contains  Refactoring: Improving the Design of Existing Code
    Wait Until Page Contains Element  xpath=//a[contains(text(),'Muokkaa lähdettä')]
    ${ref_url}=  Get Location
    Click Link  Muokkaa lähdettä
    Wait Until Location Is  ${ref_url}/edit
    Title Should Be  Muokkaa lähdettä

    Page Should Contain Element  name=name
    Page Should Contain Element  name=author
    Page Should Contain Element  name=title
    Page Should Contain Element  name=year
    Page Should Contain Element  name=publisher
    Page Should Contain Element  name=note

Edit Book Reference Form Should Autofill Correct Values
    [Documentation]  Test that the reference edit form contains the correct values for a book reference.
    Create Book Reference And Go To Home Page
    Home Page Should Be Open
    Click Link  Refactoring
    Wait Until Page Contains  Refactoring: Improving the Design of Existing Code
    Wait Until Page Contains Element  xpath=//a[contains(text(),'Muokkaa lähdettä')]
    Click Link  Muokkaa lähdettä
    Title Should Be  Muokkaa lähdettä

    Textfield Value Should Be  name=name  Refactoring
    Textfield Value Should Be  name=author  Martin Fowler, Kent Beck
    Textfield Value Should Be  name=title  Refactoring: Improving the Design of Existing Code
    Textfield Value Should Be  name=year  1999
    Textfield Value Should Be  name=publisher  Addison-Wesley Professional
    Textfield Value Should Be  name=note  Testimuistiinpanot

User Can Edit Book Reference And See Changes On Reference Page
    [Documentation]  Test that user can edit a book reference and see the changes on the reference page.
    Create Book Reference And Go To Home Page
    Home Page Should Be Open
    Click Link  Refactoring
    Wait Until Page Contains  Refactoring: Improving the Design of Existing Code
    Wait Until Page Contains Element  xpath=//a[contains(text(),'Muokkaa lähdettä')]
    ${ref_url}=  Get Location
    Click Link  Muokkaa lähdettä
    Wait Until Location Is  ${ref_url}/edit
    Title Should Be  Muokkaa lähdettä

    Input Text  name=name  EditedRefactoring2024
    Input Text  name=author  Edited Book Author
    Input Text  name=title  Edited Book Title
    Input Text  name=year  2024
    Input Text  name=publisher  Edited Publisher
    Input Text  name=note  Edited Book Note
    
    Click Button  Tallenna muutokset
    Wait Until Location Is  ${ref_url}

    Page Should Contain  EditedRefactoring2024
    Page Should Contain  Edited Book Author
    Page Should Contain  Edited Book Title
    Page Should Contain  2024
    Page Should Contain  Edited Publisher
    Page Should Contain  Edited Book Note

Edit Book Reference With Invalid Data Shows Validation Error Messages
    [Documentation]  Test that submitting invalid book reference data shows the correct validation error messages.
    [Template]    Validate Book Reference Edit Form Errors
    # Name           Author            Editor            Title            Publisher            Year             Note            Expected Error
    ${VALID_BNAME}   ${VALID_BAUTHOR}  ${VALID_BEDITOR}  ${VALID_BTITLE}  ${VALID_BPUBLISHER}  two thousand     ${VALID_BNOTE}  Vuoden oltava luku
    ${VALID_BNAME}   ${VALID_BAUTHOR}  ${VALID_BEDITOR}  CC               ${VALID_BPUBLISHER}  ${VALID_BYEAR}   ${VALID_BNOTE}  Liian lyhyt nimi
    ${VALID_BNAME}   R                 ${VALID_BEDITOR}  ${VALID_BTITLE}  ${VALID_BPUBLISHER}  ${VALID_BYEAR}   ${VALID_BNOTE}  Liian lyhyt kirjoittaja
    ${VALID_BNAME}   Author1           ${VALID_BEDITOR}  ${VALID_BTITLE}  ${VALID_BPUBLISHER}  ${VALID_BYEAR}   ${VALID_BNOTE}  Kirjoittajan nimessä ei kuulu olla numeroita
    ${VALID_BNAME}   ${VALID_BAUTHOR}  ${VALID_BEDITOR}  ${VALID_BTITLE}  A                    ${VALID_BYEAR}   ${VALID_BNOTE}  Liian lyhyt julkaisija
    ${VALID_BNAME}   ${VALID_BAUTHOR}  ${VALID_BEDITOR}  ${VALID_BTITLE}  Pub2                 ${VALID_BYEAR}   ${VALID_BNOTE}  Julkaisijan nimessä ei kuulu olla numeroita
    ${VALID_BNAME}   ${VALID_BAUTHOR}  R                 ${VALID_BTITLE}  ${VALID_BPUBLISHER}  ${VALID_BYEAR}   ${VALID_BNOTE}  Liian lyhyt muokkaaja
    ${VALID_BNAME}   ${VALID_BAUTHOR}  Ed1               ${VALID_BTITLE}  ${VALID_BPUBLISHER}  ${VALID_BYEAR}   ${VALID_BNOTE}  Muokkaajan nimessä ei kuulu olla numeroita 


*** Keywords ***
Create Book Reference And Go To Home Page
    Create Book  Refactoring  Martin Fowler, Kent Beck  Refactoring: Improving the Design of Existing Code  1999  Martin Fowler  Addison-Wesley Professional  Testimuistiinpanot
    Go To Home Page

Create Article Reference And Go To Home Page
    Create Article  attention2017  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is All You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Go To Home Page

Validate Book Reference Edit Form Errors
    [Documentation]  Fills the form and asserts that the expected error appears
    [Arguments]    ${name}  ${author}  ${editor}  ${title}  ${publisher}  ${year}  ${note}  ${expected_error}
    Create Book Reference And Go To Home Page
    Home Page Should Be Open
    Click Link  Refactoring
    Wait Until Page Contains  Refactoring: Improving the Design of Existing Code
    Wait Until Page Contains Element  xpath=//a[contains(text(),'Muokkaa lähdettä')]
    Click Link  Muokkaa lähdettä
    Title Should Be  Muokkaa lähdettä

    Submit Book Form With Data  ${name}  ${author}  ${editor}  ${title}  ${publisher}  ${year}  ${note}
    Page Should Contain    ${expected_error}

Validate Article Reference Edit Form Errors
    [Documentation]  Fills the form and asserts that the expected error appears
    [Arguments]    ${name}  ${author}  ${title}  ${journal}  ${year}  ${note}  ${expected_error}
    Create Article Reference And Go To Home Page
    Home Page Should Be Open
    Click Link  attention2017
    Wait Until Page Contains  Attention Is All You Need
    Wait Until Page Contains Element  xpath=//a[contains(text(),'Muokkaa lähdettä')]
    Click Link  Muokkaa lähdettä
    Title Should Be  Muokkaa lähdettä
    
    Submit Article Form With Data  ${name}  ${author}  ${title}  ${journal}  ${year}  ${note}
    Page Should Contain    ${expected_error}

