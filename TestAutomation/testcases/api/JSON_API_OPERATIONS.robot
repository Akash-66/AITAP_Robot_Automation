*** Settings ***
Library           JSONLibrary
Library           OperatingSystem
Library           Collections
Library           RequestsLibrary
Library           String

*** Test Cases ***
JSON API POST METHOD
    [Tags]    robot:continue-on-failure
    Create Session    mysession    https://thetestingworldapi.com/api    verify=True
    ${request_body}    Get File    .\\config\\api\\JSON\\StudentDetailsPost.json
    ${request_header}    Create Dictionary    Content-Type=application/json
    ${response}    POST On Session    mysession    /studentsDetails    data=${request_body}    headers=${request_header}    expected_status=any
    TRY
        Should Be Equal As Strings    ${response.status_code}    201
        ${response_content}    Set Variable    ${response.content}
        Log To Console    ${response_content}
    EXCEPT
        Log To Console    ${response.status_code}
    END

JSON API GET METHOD
    [Tags]    robot:continue-on-failure
    Create Session    mysession    https://jsonplaceholder.typicode.com    verify=True
    ${response}    GET On Session    mysession    /todos/1    expected_status=any
    ${response_status}    Set Variable    ${response.status_code}
    Log To Console    ${response_status}
    IF    $response_status==200
        ${response_content}    Set Variable    ${response.content}
        ${response_content}    To Json    ${response_content}
        ${Title}    Get Value From Json    ${response_content}    title
        Log To Console    Title is ${Title}
    ELSE
        Log To Console    Oh no API failed :)
    END
