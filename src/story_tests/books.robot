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

User Cannot Add Book Reference With Non-numeric Year
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
    Input Text  css=form[name='Kirja'] input[name='year']        two thousand eight
    Input Text  css=form[name='Kirja'] input[name='note']        Testikommentti
    Click Button  css=form[name='Kirja'] input[type='submit']
    Create New Reference Page Should Be Open

User Cannot Add Book Reference With Too Short Title
    [Documentation]  Adding a book reference with a too short title shows a warning.
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Press Keys  id=reference_selector  Kirja  ENTER
    Wait Until Page Contains  Kirjan nimi
    Input Text  css=form[name='Kirja'] input[name='name']        Clean Code
    Input Text  css=form[name='Kirja'] input[name='author']      Robert C. Martin
    Input Text  css=form[name='Kirja'] input[name='editor']      Robert C. Martin
    Input Text  css=form[name='Kirja'] input[name='title']       CC
    Input Text  css=form[name='Kirja'] input[name='publisher']   Addison-Wesley Professional
    Input Text  css=form[name='Kirja'] input[name='year']        2008
    Input Text  css=form[name='Kirja'] input[name='note']        Testikommentti
    Click Button  css=form[name='Kirja'] input[type='submit']
    Page Should Contain  Liian lyhyt nimi

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

User Gets Warning When Adding Book Reference With Too Short Author
    [Documentation]  Adding a book reference with a too short author name shows a warning.
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Press Keys  id=reference_selector  Kirja  ENTER
    Wait Until Page Contains  Kirjan nimi
    Input Text  css=form[name='Kirja'] input[name='name']        Clean Code
    Input Text  css=form[name='Kirja'] input[name='author']      R
    Input Text  css=form[name='Kirja'] input[name='editor']      Robert C. Martin
    Input Text  css=form[name='Kirja'] input[name='title']       Clean Code: A Handbook of Agile Software Craftsmanship
    Input Text  css=form[name='Kirja'] input[name='publisher']   Addison-Wesley Professional
    Input Text  css=form[name='Kirja'] input[name='year']        2008
    Input Text  css=form[name='Kirja'] input[name='note']        Testikommentti
    Click Button  css=form[name='Kirja'] input[type='submit']
    Page Should Contain  Liian lyhyt kirjoittaja

User Gets Warning When Adding Book Reference With Author Name Containing Numbers
    [Documentation]  Adding a book reference with numbers in the author name shows a warning.
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

User Gets Warning When Adding Book Reference With Too Short Publisher
    [Documentation]  Adding a book reference with a too short publisher shows a warning.
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Press Keys  id=reference_selector  Kirja  ENTER
    Wait Until Page Contains  Kirjan nimi
    Input Text  css=form[name='Kirja'] input[name='name']        Clean Code
    Input Text  css=form[name='Kirja'] input[name='author']      Robert C. Martin
    Input Text  css=form[name='Kirja'] input[name='editor']      Robert C. Martin
    Input Text  css=form[name='Kirja'] input[name='title']       Clean Code: A Handbook of Agile Software Craftsmanship
    Input Text  css=form[name='Kirja'] input[name='publisher']   A
    Input Text  css=form[name='Kirja'] input[name='year']        2008
    Input Text  css=form[name='Kirja'] input[name='note']        Testikommentti
    Click Button  css=form[name='Kirja'] input[type='submit']
    Page Should Contain  Liian lyhyt julkaisija

User Gets Warning When Adding Book Reference With Publisher Containing Numbers
    [Documentation]  Adding a book reference with numbers in the publisher name shows a warning.
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Press Keys  id=reference_selector  Kirja  ENTER
    Wait Until Page Contains  Kirjan nimi
    Input Text  css=form[name='Kirja'] input[name='name']        Clean Code
    Input Text  css=form[name='Kirja'] input[name='author']      Robert C. Martin
    Input Text  css=form[name='Kirja'] input[name='editor']      Robert C. Martin
    Input Text  css=form[name='Kirja'] input[name='title']       Clean Code: A Handbook of Agile Software Craftsmanship
    Input Text  css=form[name='Kirja'] input[name='publisher']   Addison-Wesley Professional2
    Input Text  css=form[name='Kirja'] input[name='year']        2008
    Input Text  css=form[name='Kirja'] input[name='note']        Testikommentti
    Click Button  css=form[name='Kirja'] input[type='submit']
    Page Should Contain  Julkaisijan nimessä ei kuulu olla numeroita

User Gets Warning When Adding Book Reference With Too Short Editor
    [Documentation]  Adding a book reference with a too short editor name shows a warning.
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Press Keys  id=reference_selector  Kirja  ENTER
    Wait Until Page Contains  Kirjan nimi
    Input Text  css=form[name='Kirja'] input[name='name']        Clean Code
    Input Text  css=form[name='Kirja'] input[name='author']      Robert C. Martin
    Input Text  css=form[name='Kirja'] input[name='editor']      R
    Input Text  css=form[name='Kirja'] input[name='title']       Clean Code: A Handbook of Agile Software Craftsmanship
    Input Text  css=form[name='Kirja'] input[name='publisher']   Addison-Wesley Professional
    Input Text  css=form[name='Kirja'] input[name='year']        2008
    Input Text  css=form[name='Kirja'] input[name='note']        Testikommentti
    Click Button  css=form[name='Kirja'] input[type='submit']
    Page Should Contain  Liian lyhyt muokkaaja

User Gets Warning When Adding Book Reference With Editor Name Containing Numbers
    [Documentation]  Adding a book reference with numbers in the editor name shows a warning.
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Press Keys  id=reference_selector  Kirja  ENTER
    Wait Until Page Contains  Kirjan nimi
    Input Text  css=form[name='Kirja'] input[name='name']        Clean Code
    Input Text  css=form[name='Kirja'] input[name='author']      Robert C. Martin
    Input Text  css=form[name='Kirja'] input[name='editor']      Robert C. Martin2
    Input Text  css=form[name='Kirja'] input[name='title']       Clean Code: A Handbook of Agile Software Craftsmanship
    Input Text  css=form[name='Kirja'] input[name='publisher']   Addison-Wesley Professional
    Input Text  css=form[name='Kirja'] input[name='year']        2008
    Input Text  css=form[name='Kirja'] input[name='note']        Testikommentti
    Click Button  css=form[name='Kirja'] input[type='submit']
    Page Should Contain  Muokkaajan nimessä ei kuulu olla numeroita


*** Keywords ***
Create Book Reference And Go To Home Page
    Create Book  Refactoring  Martin Fowler, Kent Beck  Refactoring: Improving the Design of Existing Code  1999  Martin Fowler  Addison-Wesley Professional  Testimuistiinpanot
    Go To Home Page


