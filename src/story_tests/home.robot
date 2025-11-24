*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset Database And Go To Home Page

*** Test Cases ***
Click Add Reference Link
    Home Page Should Be Open
    Click Link  Lisää Lähde
    Create New Reference Page Should Be Open
    Page Should Contain Element  name=name
    Page Should Contain Element  name=author
    Page Should Contain Element  name=editor
    Page Should Contain Element  name=publisher
    Page Should Contain Element  name=year
    Page Should Contain Element  name=note
    