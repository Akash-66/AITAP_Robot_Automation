*** Settings ***
Library           OperatingSystem
Library           RequestsLibrary
Library           XML
Library           Collections
Resource          ../../resources/SoapMethods.resource

*** Test Cases ***
IF_Operator
    [Tags]    robot:continue-on-failure
    ${name}    Set Variable    Akash
    IF    $name=='Akash'
        Log    ${name}
    ELSE
        Log    Not found
    END
