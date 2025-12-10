*** Settings ***
Resource  resource.robot
Library  RequestsLibrary
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset Database And Go To Home Page

*** Test Cases ***
Click Add Reference Link
    [Documentation]  Test that the "Lisää Lähde" link on the home page navigates to the Create New Reference page.
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Page Should Contain Element  name=name
    Page Should Contain Element  name=author
    Page Should Contain Element  name=editor
    Page Should Contain Element  name=publisher
    Page Should Contain Element  name=year
    Page Should Contain Element  name=note

CSS File Is Loaded On Home Page
    [Documentation]  Test that the CSS file is correctly loaded on the home page.
    Home Page Should Be Open
    Page Should Contain Element  css=link[rel="stylesheet"][href="/static/main.css"]

Home Page Contains BibTex Download Button
    [Documentation]  The home page contains a button to download references in BibTex format.
    Home Page Should Be Open
    Page Should Contain Element  css=form[id=downloadForm]
    Page Should Contain Button  Lataa valitut

Downloaded BibTex Contains All Created References
    [Documentation]  The downloaded BibTex file contains all of the created references.
    Create Two References And Go To Home Page
    Home Page Should Be Open
    Create Session  bibtex_session  ${HOME_URL}
    ${response}=  GET On Session  bibtex_session  /download_bibtex
    ${bibtex}=  Convert To String  ${response.content}

    Should Contain  ${bibtex}  @article{attention2017,
    Should Match Regexp  ${bibtex}  (?s).*author\\s*=\\s*"Ashish.*
    Should Match Regexp  ${bibtex}  (?s).*title\\s*=\\s*"Attention Is All You Need".*
    Should Match Regexp  ${bibtex}  (?s).*journal\\s*=\\s*"Advances in Neural Information Processing Systems".*
    Should Match Regexp  ${bibtex}  (?s).*year\\s*=\\s*"2017".*
    Should Match Regexp  ${bibtex}  (?s).*note\\s*=\\s*"Testiartikkeli".*

    Should Contain  ${bibtex}  @book{Refactoring,
    Should Match Regexp  ${bibtex}  (?s).*author\\s*=\\s*"Martin Fowler, Kent Beck".*
    Should Match Regexp  ${bibtex}  (?s).*title\\s*=\\s*"Refactoring: Improving the Design of Existing Code".*
    Should Match Regexp  ${bibtex}  (?s).*publisher\\s*=\\s*"Addison-Wesley Professional".*
    Should Match Regexp  ${bibtex}  (?s).*year\\s*=\\s*"1999".*
    Should Match Regexp  ${bibtex}  (?s).*note\\s*=\\s*"Testimuistiinpanot".*


*** Keywords ***
Create Two References And Go To Home Page
    Create Article  attention2017  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is All You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Create Book  Refactoring  Martin Fowler, Kent Beck  Refactoring: Improving the Design of Existing Code  1999  Martin Fowler  Addison-Wesley Professional  Testimuistiinpanot
    Go To Home Page
