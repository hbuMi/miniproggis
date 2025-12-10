*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset Database And Go To Home Page

*** Test Cases ***
User Can Automatically Fill Reference Fields From DOI
    [Documentation]  Test that user can fill reference fields automatically by providing a valid DOI.
    Go To Create New Reference Page
    Page Should Contain Element  css=form[name="DOI"][action="/fill_from_doi"]
