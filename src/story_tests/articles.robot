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

User Cannot Add Article Reference With Non-numeric Year
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Press Keys  id=reference_selector  Artikkeli  ENTER
    Wait Until Page Contains  Artikkelin nimi
    Input Text  css=form[name='Artikkeli'] input[name='name']        attention2017
    Input Text  css=form[name='Artikkeli'] input[name='author']      Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin
    Input Text  css=form[name='Artikkeli'] input[name='title']       Attention Is All You Need
    Input Text  css=form[name='Artikkeli'] input[name='journal']     Advances in Neural Information Processing Systems
    Input Text  css=form[name='Artikkeli'] input[name='year']        twentyseventeen
    Input Text  css=form[name='Artikkeli'] input[name='note']        Testiartikkeli
    Click Button  css=form[name='Artikkeli'] input[type='submit']
    Create New Reference Page Should Be Open

User Cannot Add Article Reference With Too Short Title
    [Documentation]  Adding an article reference with a too short title shows a warning.
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Press Keys  id=reference_selector  Artikkeli  ENTER
    Wait Until Page Contains  Artikkelin nimi
    Input Text  css=form[name='Artikkeli'] input[name='name']        attention2017
    Input Text  css=form[name='Artikkeli'] input[name='author']      Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin
    Input Text  css=form[name='Artikkeli'] input[name='title']       AI
    Input Text  css=form[name='Artikkeli'] input[name='journal']     Advances in Neural Information Processing Systems
    Input Text  css=form[name='Artikkeli'] input[name='year']        2017
    Input Text  css=form[name='Artikkeli'] input[name='note']        Testiartikkeli
    Click Button  css=form[name='Artikkeli'] input[type='submit']
    Page Should Contain  Liian lyhyt nimi

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

User Gets Warning When Adding Article Reference With Too Short Author
    [Documentation]  Adding an article reference without an author shows a warning.
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Press Keys  id=reference_selector  Artikkeli  ENTER
    Wait Until Page Contains  Artikkelin nimi
    Input Text  css=form[name='Artikkeli'] input[name='name']        attention2017
    Input Text  css=form[name='Artikkeli'] input[name='title']       Attention Is All You Need
    Input Text  css=form[name='Artikkeli'] input[name='journal']     Advances in Neural Information Processing Systems
    Input Text  css=form[name='Artikkeli'] input[name='year']        2017
    Input Text  css=form[name='Artikkeli'] input[name='note']        Testiartikkeli
    Click Button  css=form[name='Artikkeli'] input[type='submit']
    Page Should Contain  Liian lyhyt kirjoittaja

User Gets Warning When Adding Article Reference With Author Name Containing Numbers
    [Documentation]  Adding an article reference with numbers in the author name shows a warning.
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

User Gets Warning When Adding Article Reference With Too Short Journal
    [Documentation]  Adding an article reference with a too short journal shows a warning.
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
    Input Text  css=form[name='Artikkeli'] input[name='journal']     A
    Input Text  css=form[name='Artikkeli'] input[name='note']        Testiartikkeli
    Click Button  css=form[name='Artikkeli'] input[type='submit']
    Page Should Contain  Liian lyhyt julkaisija

User Gets Warning When Adding Article Reference With Journal Containing Numbers
    [Documentation]  Adding an article reference with numbers in the journal shows a warning.
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Press Keys  id=reference_selector  Artikkeli  ENTER
    Wait Until Page Contains  Artikkelin nimi
    Input Text  css=form[name='Artikkeli'] input[name='name']        attention2017
    Input Text  css=form[name='Artikkeli'] input[name='author']      Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin
    Input Text  css=form[name='Artikkeli'] input[name='title']       Attention Is All You Need
    Input Text  css=form[name='Artikkeli'] input[name='journal']     Advances in Neural Information Processing Systems 2021
    Input Text  css=form[name='Artikkeli'] input[name='year']        2017
    Input Text  css=form[name='Artikkeli'] input[name='note']        Testiartikkeli
    Click Button  css=form[name='Artikkeli'] input[type='submit']
    Page Should Contain  Julkaisijan nimessä ei kuulu olla numeroita

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


*** Keywords ***
Create Article Reference And Go To Home Page
    Create Article  attention2017  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is All You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Go To Home Page
