*** Settings ***
Library           JSONLibrary
Library           OperatingSystem
Library           Collections
Library           RequestsLibrary
Library           String

*** Test Cases ***
JSON API POST METHOD
    [Tags]    robot:continue-on-failure
    Create Session    mysession    https://jsonplaceholder.typicode.com    verify=True
    ${request_body}    Create Dictionary    userId=2    id=2    title=API Post Method    completed=false
    ${request_header}    Create Dictionary    Content-Type=application/json
    ${response}    POST On Session    mysession    /todos/1    data=${request_body}    headers=${request_header}    expected_status=any
    Log To Console    ${response.content}

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
