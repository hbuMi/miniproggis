*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset Database And Go To Home Page

*** Test Cases ***
User Can Add Article Reference
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Press Keys  id=reference_selector  Artikkeli  ENTER
    Wait Until Page Contains  Artikkelin nimi
    Input Text  css=form[name='Artikkeli'] input[name='name']        attention2017
    Input Text  css=form[name='Artikkeli'] input[name='author']      Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin
    Input Text  css=form[name='Artikkeli'] input[name='title']       Attention Is All You Need
    Input Text  css=form[name='Artikkeli'] input[name='journal']     Advances in Neural Information Processing Systems
    Input Text  css=form[name='Artikkeli'] input[name='year']        2017
    Input Text  css=form[name='Artikkeli'] input[name='note']        Testiartikkeli
    Click Button  css=form[name='Artikkeli'] input[type='submit']
    Wait Until Location Is  ${HOME_URL}/
    Home Page Should Be Open
    Page Should Contain  attention2017

User Can View Article Reference Details
    Create Article Reference And Go To Home Page
    Home Page Should Be Open
    Page Should Contain  attention2017
    Click Link  attention2017
    Location Should Contain  /reference/article/
    Title Should Be  Lähde
    Page Should Contain  Attention Is All You Need
    Page Should Contain  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin
    Page Should Contain  Advances in Neural Information Processing Systems
    Page Should Contain  2017
    Page Should Contain  Testiartikkeli

New Article Reference Form Retains Entered Values On Validation Error
    [Documentation]  When adding an article reference fails due to validation error, the form retains the entered values.
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Press Keys  id=reference_selector  Artikkeli  ENTER
    Wait Until Page Contains  Artikkelin nimi
    Input Text  css=form[name='Artikkeli'] input[name='name']        attention2017
    Input Text  css=form[name='Artikkeli'] input[name='author']      Ashish Vaswani1, Noam Shazeer2
    Input Text  css=form[name='Artikkeli'] input[name='title']       Attention Is All You Need
    Input Text  css=form[name='Artikkeli'] input[name='journal']     Advances in Neural Information Processing Systems
    Input Text  css=form[name='Artikkeli'] input[name='year']        2017
    Input Text  css=form[name='Artikkeli'] input[name='note']        Testiartikkeli
    Click Button  css=form[name='Artikkeli'] input[type='submit']
    Page Should Contain  Kirjoittajan nimessä ei kuulu olla numeroita
    Textfield Value Should Be  css=form[name='Artikkeli'] input[name='name']        attention2017
    Textfield Value Should Be  css=form[name='Artikkeli'] input[name='author']      Ashish Vaswani1, Noam Shazeer2
    Textfield Value Should Be  css=form[name='Artikkeli'] input[name='title']       Attention Is All You Need
    Textfield Value Should Be  css=form[name='Artikkeli'] input[name='journal']     Advances in Neural Information Processing Systems
    Textfield Value Should Be  css=form[name='Artikkeli'] input[name='year']        2017
    Textfield Value Should Be  css=form[name='Artikkeli'] input[name='note']        Testiartikkeli

Create Article Reference With Invalid Input Data Shows Correct Validation Error Messages
    [Documentation]  Test that submitting invalid article reference data shows the correct validation error messages.
    [Template]    Validate Article Reference Create Form Errors
    # Name           Author           Title            Journal             Year            Note            Expected Error
    ${VALID_ANAME}  ${VALID_AAUTHOR}  ${VALID_ATITLE}  ${VALID_AJOURNAL}   twenty          ${VALID_ANOTE}  Vuoden oltava luku
    ${VALID_ANAME}  ${VALID_AAUTHOR}  Ab               ${VALID_AJOURNAL}   ${VALID_AYEAR}  ${VALID_ANOTE}  Liian lyhyt nimi
    ${VALID_ANAME}  As                ${VALID_ATITLE}  ${VALID_AJOURNAL}   ${VALID_AYEAR}  ${VALID_ANOTE}  Liian lyhyt kirjoittaja
    ${VALID_ANAME}  Ashish Vaswani1   ${VALID_ATITLE}  ${VALID_AJOURNAL}   ${VALID_AYEAR}  ${VALID_ANOTE}  Kirjoittajan nimessä ei kuulu olla numeroita
    ${VALID_ANAME}  ${VALID_AAUTHOR}  ${VALID_ATITLE}  A                   ${VALID_AYEAR}  ${VALID_ANOTE}  Liian lyhyt julkaisija


*** Keywords ***
Create Article Reference And Go To Home Page
    Create Article  attention2017  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is All You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Go To Home Page

Validate Article Reference Create Form Errors
    [Documentation]  Fills the form and asserts that the expected error appears
    [Arguments]    ${name}  ${author}  ${title}  ${journal}  ${year}  ${note}  ${expected_error}
    Go To Create New Article Reference Page
    Submit Article Form With Data  ${name}  ${author}  ${title}  ${journal}  ${year}  ${note}
    Page Should Contain    ${expected_error}
