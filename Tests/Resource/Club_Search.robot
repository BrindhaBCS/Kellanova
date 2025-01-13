*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    kellanova.py
Library    string
*** Variables ***
${URL}    ${angvar('clubcracker_url')}
${Browser}    ${angvar('clubcracker_browser')}
*** Keywords ***
Browser
    Open Browser    url=${URL}    browser=${Browser}    options=add_argument("--ignore-certificate-errors")
    Maximize Browser Window
Response_check
    ${response_code}=    Execute JavaScript    return fetch("${URL}").then(response => response.status)
    Should Be Equal As Numbers    ${response_code}    200
    Log    Response Code: ${response_code}
    IF  '${response_code}' == '200'
        Log To Console    message=The application has successfully processed the request and returned a response with status code 200....
    ELSE
        Log To Console    message=The application did not load properly and returned an unexpected result. Please check your internet connection and verify that the application is working correctly.......
        Close All Browsers
    END

    Wait Until Keyword Succeeds    1 minute    2s    Click Element    locator=id:onetrust-accept-btn-handler
    ${Get_Cookies}    Get Cookies
Page_title
    ${status}    Title_match
    IF  '${status}' == 'True'
        Log To Console    message=The title of the web application should match the expected value to ensure consistency, accuracy, and proper navigation within the interface.....
    ELSE
        Log To Console    message=The application does not match the expected title, leading to potential issues in functionality and user experience....
        Close All Browsers
    END

search_icon
    ${search}    Run Keyword And Return Status    Page Should Contain Element    locator=xpath://button[@class='search-button']
    IF  '${search}' == 'True'
        Click Element    locator=xpath://button[@class='search-button']
        Input Text    locator=id:search-q    text=Club
        Sleep    time_=2s
        Capture Element Screenshot    locator=id:search    filename=Homesearch.png
        Click Element    locator=xpath://a[text()="Recipes"]
        Capture Element Screenshot    locator=id:recipe_search_form    filename=Recipessearch.png
        Input Text    locator=id:recipe-search-q    text=Apple
        Click Element    locator=recipe-search-submit
        Sleep    time_=1s
        Capture Page Screenshot    filename=Recipessearchfull.png
        Log To Console    message=The search button is contained on that page and is easily accessible.
    ELSE
        Log To Console    message=Search-button header is missing on this page..
    END
    Copy Images    ${OUTPUT_DIR}    ${angvar('vm_path_dir')}
    Sleep	1

*** Keywords ***
Title_match
    ${Get_Window_Titles}    Get Window Titles
    ${condition}    Run Keyword And Return Status    Should Be Equal As Strings    first=${Get_Window_Titles}    second=['Buttery Crackers | Club® Crackers']
    [Return]    ${condition} 