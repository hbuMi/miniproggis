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
    Press Keys  id=reference_selector  Kirja  ENTER
    Wait Until Page Contains  Kirjan nimi
    Input Text  css=form[name='Kirja'] input[name='name']        Clean Code
    Input Text  css=form[name='Kirja'] input[name='author']      Robert C. Martin
    Input Text  css=form[name='Kirja'] input[name='editor']      Robert C. Martin
    Input Text  css=form[name='Kirja'] input[name='title']       Clean Code: A Handbook of Agile Software Craftsmanship
    Input Text  css=form[name='Kirja'] input[name='publisher']   Addison-Wesley Professional
    Input Text  css=form[name='Kirja'] input[name='year']        2008
    Input Text  css=form[name='Kirja'] input[name='note']        Testikommentti
    Click Button  css=form[name='Kirja'] input[type='submit']
    Wait Until Location Is  ${HOME_URL}/
    Home Page Should Be Open
    Page Should Contain  Clean Code

User Can View Book Reference Details
    Create Book Reference And Go To Home Page
    Home Page Should Be Open
    Page Should Contain  Refactoring
    Click Link  Refactoring
    Location Should Contain  /reference/book/
    Title Should Be  Lähde
    Page Should Contain  Refactoring: Improving the Design of Existing Code
    Page Should Contain  Martin Fowler, Kent Beck
    Page Should Contain  Addison-Wesley Professional
    Page Should Contain  1999
    Page Should Contain  Testimuistiinpanot

New Book Reference Form Retains Entered Values On Validation Error
    [Documentation]  When a validation error occurs, the new book reference form retains the entered values.
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Press Keys  id=reference_selector  Kirja  ENTER
    Wait Until Page Contains  Kirjan nimi
    Input Text  css=form[name='Kirja'] input[name='name']        Clean Code
    Input Text  css=form[name='Kirja'] input[name='author']      Robert C. Martin1
    Input Text  css=form[name='Kirja'] input[name='editor']      Robert C. Martin
    Input Text  css=form[name='Kirja'] input[name='title']       Clean Code: A Handbook of Agile Software Craftsmanship
    Input Text  css=form[name='Kirja'] input[name='publisher']   Addison-Wesley Professional
    Input Text  css=form[name='Kirja'] input[name='year']        2008
    Input Text  css=form[name='Kirja'] input[name='note']        Testikommentti
    Click Button  css=form[name='Kirja'] input[type='submit']
    Page Should Contain  Kirjoittajan nimessä ei kuulu olla numeroita
    Textfield Value Should Be  css=form[name='Kirja'] input[name='name']        Clean Code
    Textfield Value Should Be  css=form[name='Kirja'] input[name='author']      Robert C. Martin1
    Textfield Value Should Be  css=form[name='Kirja'] input[name='editor']      Robert C. Martin
    Textfield Value Should Be  css=form[name='Kirja'] input[name='title']       Clean Code: A Handbook of Agile Software Craftsmanship
    Textfield Value Should Be  css=form[name='Kirja'] input[name='publisher']   Addison-Wesley Professional
    Textfield Value Should Be  css=form[name='Kirja'] input[name='year']        2008
    Textfield Value Should Be  css=form[name='Kirja'] input[name='note']        Testikommentti

Create Book Reference With Invalid Input Data Shows Validation Error Messages
    [Documentation]  Test that submitting invalid book reference data shows the correct validation error messages.
    [Template]    Validate Book Reference Create Form Errors
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

Validate Book Reference Create Form Errors
    [Documentation]  Fills the form and asserts that the expected error appears
    [Arguments]    ${name}  ${author}  ${editor}  ${title}  ${publisher}  ${year}  ${note}  ${expected_error}
    Go To Create New Book Reference Page
    Submit Book Form With Data  ${name}  ${author}  ${editor}  ${title}  ${publisher}  ${year}  ${note}
    Page Should Contain    ${expected_error}


