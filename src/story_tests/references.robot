*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References

*** Test Cases ***
User Can Add Book Reference
    Go To Home Page
    Home Page Should Be Open
    Click Link  Add new reference
    Create New Reference Page Should Be Open
    Input Text  title       Clean Code: A Handbook of Agile Software Craftsmanship
    Input Text  author      Robert C. Martin
    Input Text  year        2008
    Click Button  Create
    Create Book Reference Should Succeed With Message  Reference added successfully


User Can View Book References
    Reset References Create Reference And Go To Home Page
    Click Link  Show references
    Show References Page Should Be Open
    Page Should Contain Text  Robert C. Martin
    Page Should Contain  Clean Code: A Handbook of Agile Software Craftsmanship
    Page Should Contain  2008

*** Keywords ***
Reset References Create Reference And Go To Home Page
    Reset References
    Create Book    Robert C. Martin  Clean Code: A Handbook of Agile Software Craftsmanship  2008
    Go To Home Page

Create Book Reference Should Succeed With Message
    [Arguments]  ${message}
    Create New Reference Page Should Be Open
    Page Should Contain  ${message}