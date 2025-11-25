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
#    Page Should Contain  Vuoden oltava luku                            # Flash message needs to be added
    Create New Reference Page Should Be Open                            # Workaround checks we're still on the same page 

User Cannot Add Article Reference With Too Short Title
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
#    Page Should Contain  Liian lyhyt nimi                               # Flash message needs to be added
    Create New Reference Page Should Be Open                             # Workaround checks we're still on the same page 

User Can View Article Reference Details
    Create Article Reference And Go To Home Page
    Home Page Should Be Open
    Page Should Contain  attention2017
    Click Link  attention2017
    Location Should Contain  /reference/article/
    Title Should Be  Lähde
    Page Should Contain  Attention Is All You Need
    Page Should Contain  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin
    # Page Should Contain  Advances in Neural Information Processing Systems   # Journal name not currently displayed
    Page Should Contain  2017
    Page Should Contain  Testiartikkeli

*** Keywords ***
Create Article Reference And Go To Home Page
    Create Article  attention2017  Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin  Attention Is All You Need  2017  Advances in Neural Information Processing Systems  Testiartikkeli
    Go To Home Page