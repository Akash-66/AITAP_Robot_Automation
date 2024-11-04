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

JSON API BEARER AUTHORIZATION
    [Tags]    robot:continue-on-failure
    Create Session    mysession    https://dummyjson.com    verify=True
    ${request_body}    Create Dictionary    username=emilys    password=emilyspass    expiresInMins=30
    ${request_body}    Convert Json To String    ${request_body}
    ${request_header}    Create Dictionary    Content-Type=application/json
    ${response}    POST On Session    mysession    /auth/login    data=${request_body}    headers=${request_header}    expected_status=any    #logging in to access token
    TRY
        ${response_content}    Set Variable    ${response.content}
        ${response_content}    Convert String To Json    ${response_content}
        ${token}    Get Value From Json    ${response_content}    accessToken    #storing token value for next method (GET), it will store as list value
        ${token}    Set Variable    ${token}[0]    #accesing list value and setting as a varibale
        ${request_header}    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json    #header authorization code
        ${response}    GET On Session    mysession    /auth/me    headers=${request_header}    expected_status=any
        Should Be Equal As Strings    ${response.status_code}    200
        ${MSG} Set Variable    ${response.status_code}
    EXCEPT
        ${MSG} Set Variable    ${response.status_code}
    END
