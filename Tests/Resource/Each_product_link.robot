*** Settings ***
Library    SeleniumLibrary

*** Variables ***

${EXPECTED_TEXT}    Cookies On Our Website
${OK_BUTTON_XPATH}    //button[@id='onetrust-accept-btn-handler']
${BANNER_XPATH}       //div[@role='alertdialog' and @aria-describedby='onetrust-policy-text']//h3

${BUY_BUTTON}    //a[@aria-label='click to see where to buy']

*** Keywords ***
Start TestCase
    Log    Opening browser
    Open Browser    ${angvar('clubcracker_url')}    ${angvar('clubcracker_browser')}
    Maximize Browser Window
    Handle Pop-up
    Sleep    2
    Log    Browser opened successfully

Products should load on Product Pages
    Wait Until Element Is Visible    xpath:(//div[@class='content_wrapper'])[3]    60s
    Sleep    2
    Execute Javascript    window.scrollTo(0, 600)
    Sleep    1

    ${product_count}=    Get Element Count    xpath://div[@class='products-list-product']
    Log    Total products found: ${product_count}

    FOR    ${index}    IN RANGE    1    ${product_count + 1}
        
        Click Element    xpath:(//div[@class='product-list-title bvValues'])[${index}]
        Sleep    1
        Wait Until Element Is Visible    xpath://a[@aria-label='click to see where to buy']    60s
        Sleep    1
        Capture Element Screenshot    xpath://section[@class='product-detail-highlights section--in-viewport']
        Sleep    1
        Go Back
        Wait Until Element Is Visible    xpath://h2[text()='Our Food']/following-sibling::div    60s
   
    END
    Copy Images    ${OUTPUT_DIR}    ${angvar('vm_path_dir')}
    Sleep    2


    
        

Handle Pop-up
    Wait Until Page Contains Element    ${BANNER_XPATH}    timeout=10
    ${actual_text}=    Get Text    ${BANNER_XPATH}
    Should Be Equal As Strings    ${actual_text}    ${EXPECTED_TEXT}
    Click Element    ${OK_BUTTON_XPATH}