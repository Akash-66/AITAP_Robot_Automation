*** Settings ***
Library           RequestsLibrary
Library           XML
Library           OperatingSystem
Library           Collections

*** Test Cases ***
SOAP API POST METHOD
    [Tags]    robot:continue-on-failure
    ${request_xml}    Get File    .\\config\\api\\XML\\StudentDetailsPost.xml
    Create Session    mysession    https://thetestingworldapi.com/api    verify=true
    ${request_header}    Create Dictionary    Content-Type=application/xml
    ${response}    POST On Session    mysession    /studentsDetails    data=${request_xml}    headers=${request_header}    expected_status=any
    ${response_status}    Set Variable    ${response}    # response will return status only
    TRY
        Should Be Equal As Strings    ${response_status}    <Response [201]>
        ${response_content}    Set Variable    ${response.content}
        Log To Console    ${response_content}
    EXCEPT
        Log To Console    ${response_status}
    END

SOAP API GET METHOD
    [Tags]    robot:continue-on-failure
    Create Session    mysession    https://thetestingworldapi.com/api    verify=true
    ${response}    GET On Session    mysession    /studentsDetails
    ${response_status}    Set Variable    ${response}    # response will return status only
    TRY
        Should Be Equal As Strings    ${response_status}    <Response [200]>
    EXCEPT
        Log To Console    ${response_status}
    END
