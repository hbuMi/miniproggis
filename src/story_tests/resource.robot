*** Settings ***
Library  SeleniumLibrary
Library  ../AppLibrary.py

*** Variables ***
${SERVER}     localhost:5001
${DELAY}      0.5 seconds
${HOME_URL}   http://${SERVER}
${RESET_URL}  http://${SERVER}/reset_db
${BROWSER}    chrome
${HEADLESS}   false

${VALID_BNAME}       Clean Code
${VALID_BAUTHOR}     Robert C. Martin
${VALID_BTITLE}      Clean Code: A Handbook of Agile Software Craftsmanship
${VALID_BPUBLISHER}  Addison-Wesley Professional
${VALID_BYEAR}       2008
${VALID_BEDITOR}     Robert C. Martin
${VALID_BNOTE}       Testikommentti

${VALID_ANAME}       attention2017
${VALID_AAUTHOR}     Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin
${VALID_ATITLE}      Attention Is All You Need
${VALID_AJOURNAL}    Advances in Neural Information Processing Systems
${VALID_AYEAR}       2017
${VALID_ANOTE}       Testiartikkeli

*** Keywords ***
Open And Configure Browser
    IF  $BROWSER == 'chrome'
        ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
        Call Method  ${options}  add_argument  --incognito    
    ELSE IF  $BROWSER == 'firefox'
        ${options}  Evaluate  sys.modules['selenium.webdriver'].FirefoxOptions()  sys
        Call Method  ${options}  add_argument  --private-window
    END
    IF  $HEADLESS == 'true'
        Set Selenium Speed  0.01 seconds
        Call Method  ${options}  add_argument  --headless
    ELSE
        Set Selenium Speed  ${DELAY}
    END
    Open Browser  browser=${BROWSER}  options=${options}

Go To Home Page
    Go To  ${HOME_URL}

Go To Create New Reference Page
    Go To  ${HOME_URL}/new_reference

Go To Create New Book Reference Page
    Go To  ${HOME_URL}/new_reference
    Press Keys  id=reference_selector  Kirja  ENTER

Go To Create New Article Reference Page
    Go To  ${HOME_URL}/new_reference
    Press Keys  id=reference_selector  Artikkeli  ENTER

Home Page Should Be Open
    Location Should Be  ${HOME_URL}/
    Title Should Be  BibTextittäjä 3000

Create New Reference Page Should Be Open
    Location Should Be  ${HOME_URL}/new_reference
    Title Should Be  Lisää lähde

Reset Database And Go To Home Page
    Reset Database
    Go To Home Page

Submit Book Form With Data
    [Documentation]  Fills and submits the book reference form with the given data
    [Arguments]    ${name}  ${author}  ${editor}  ${title}  ${publisher}  ${year}  ${note}

    IF  not "${year}".isnumeric()
        Execute Javascript  document.querySelector("form[name='Kirja'] input[id='book-year']").type = 'text'
    END

    Input Text    css=form[name='Kirja'] input[name='name']       ${name}       clear=True
    Input Text    css=form[name='Kirja'] input[name='author']     ${author}     clear=True
    Input Text    css=form[name='Kirja'] input[name='editor']     ${editor}     clear=True
    Input Text    css=form[name='Kirja'] input[name='title']      ${title}      clear=True
    Input Text    css=form[name='Kirja'] input[name='publisher']  ${publisher}  clear=True
    Input Text    css=form[name='Kirja'] input[name='year']       ${year}       clear=True
    Input Text    css=form[name='Kirja'] input[name='note']       ${note}       clear=True
    Click Button  css=form[name='Kirja'] input[type='submit']

Submit Article Form With Data
    [Documentation]  Fills and submits the article reference form with the given data
    [Arguments]    ${name}  ${author}  ${title}  ${journal}  ${year}  ${note}

    IF  not "${year}".isnumeric()
        Execute Javascript  document.querySelector("form[name='Artikkeli'] input[id='article-year']").type = 'text'
    END

    Input Text    css=form[name='Artikkeli'] input[name='name']     ${name}     clear=True
    Input Text    css=form[name='Artikkeli'] input[name='author']   ${author}   clear=True
    Input Text    css=form[name='Artikkeli'] input[name='title']    ${title}    clear=True
    Input Text    css=form[name='Artikkeli'] input[name='journal']  ${journal}  clear=True
    Input Text    css=form[name='Artikkeli'] input[name='year']     ${year}     clear=True
    Input Text    css=form[name='Artikkeli'] input[name='note']     ${note}     clear=True
    Click Button  css=form[name='Artikkeli'] input[type='submit']

