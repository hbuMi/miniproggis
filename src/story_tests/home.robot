*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References

*** Test Cases ***
Click Add Reference Link
    Go To Home Page
    Home Page Should Be Open
    Click Link  Add new reference
    Page Should Contain Title  Add Reference
    Page Should Contain Element  id=title
    Page Should Contain Element  id=author
    Page Should Contain Element  id=year

Click Show References Link
    Go To Home Page
    Home Page Should Be Open
    Click Link  Show references
    Page Should Contain Title  Reference
    
