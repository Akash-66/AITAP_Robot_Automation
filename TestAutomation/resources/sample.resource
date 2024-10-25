*** Keywords ***
sample02
    [Arguments]    ${url}
    ${path}    Get File    .//d
    Create Session    mysession    https://something
    ${request_header}    crate dictonry
    ${response}    POST On Session    mysession    https://anotherurl    body=${path}    ${request_header}    expected_status=any
    ${response}    Parse Xml    ${response.content}
    TRY
    CONTINUE
