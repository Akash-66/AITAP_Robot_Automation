*** Settings ***
Library           RequestsLibrary
Library           XML
Library           OperatingSystem
Library           Collections

*** Test Cases ***
SOAP API POST METHOD
    [Tags]    robot:continue-on-failure
    Create Session    mysession    ${base_url}    verify=true
    ${request_header}    Create Dictionary    Content-Type=application/xml
    ${response}    POST On Session    mysession    ${base_url}    data=${request_xml}    headers=${request_header}    expected_status=any
    ${response_status}    Set Variable    ${response}    # response will return status only
    ${response}    Convert To String    ${response.content}    #response.content will store response body
    ${response}    Parse Xml    ${response}
