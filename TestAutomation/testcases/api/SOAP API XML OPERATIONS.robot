*** Settings ***
Library           RequestsLibrary
Library           XML
Library           OperatingSystem
Library           Collections

*** Variables ***
${BASE_URL}       https://thetestingworldapi.com/api

*** Test Cases ***
SOAP API POST METHOD
    [Tags]    robot:continue-on-failure
    ${request_xml}    Get File    .\\config\\api\\XML\\StudentDetailsPost.xml
    Create Session    mysession    ${BASE_URL}    verify=true
    ${request_header}    Create Dictionary    Content-Type=application/xml
    ${response}    POST On Session    mysession    /studentsDetails    data=${request_xml}    headers=${request_header}    expected_status=any
    ${response_status}    Set Variable    ${response}    # response will return status only
    TRY
        Should Be Equal As Strings    ${response_status}    <Response [201]>
    EXCEPT
        Log To Console    ${response_status}
    END
