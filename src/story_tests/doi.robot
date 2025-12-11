*** Settings ***
Resource  resource.robot
Suite Setup      Setup Mock App And Browser
Suite Teardown   Close Mock App And Browser
Test Setup       Go To Mock App New Reference Page

*** Variables ***
${MOCK_APP_URL}  http://localhost:5002


*** Test Cases ***
User Can Automatically Fill Reference Fields From DOI
    [Documentation]  Test that user can fill reference fields automatically by providing a valid DOI.
    Page Should Contain Element  css=form[name="DOI"][action="/fill_from_doi"]
    Input Text  id=doi-tag  10.1000/valid_doi
    Click Button  Täytä kentät
    Wait Until Keyword Succeeds  5x  1s  Textfield Value Should Be  id=article-title  Test Article
    Textfield Value Should Be  id=article-title  Test Article
    Textfield Value Should Be  id=article-author  Tester, Alpha
    Textfield Value Should Be  id=article-year  2024
    Textfield Value Should Be  id=article-journal  Journal of Testing

User Sees Error Message For Invalid DOI
    [Documentation]  Test that user sees an error message when providing an invalid DOI.
    Page Should Contain Element  css=form[name="DOI"][action="/fill_from_doi"]
    Input Text  id=doi-tag  10.1000/invalid_doi
    Click Button  Täytä kentät
    Wait Until Page Contains  Virheellinen tai väärän lähdetyypin DOI


*** Keywords ***
Setup Mock App And Browser
    Start Mock Application
    Open And Configure Browser

Close Mock App And Browser
    Close Browser
    Stop Mock Application

Go To Mock App New Reference Page
    Go To  ${MOCK_APP_URL}/new_reference

