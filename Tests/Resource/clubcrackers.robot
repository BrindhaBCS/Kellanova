*** Settings ***
Library    SeleniumLibrary
Library    kellanova.py

*** Variables ***

${con_1}    Our Food
${con_2}    Recipes
${con_3}    where to buy
${con_4}    Contact Us

${EXPECTED_TEXT}    Cookies On Our Website
${OK_BUTTON_XPATH}    //button[@id='onetrust-accept-btn-handler']
${BANNER_XPATH}       //div[@role='alertdialog' and @aria-describedby='onetrust-policy-text']//h3

*** Keywords ***
Start TestCase
    Log    Opening browser
    Open Browser    ${angvar('clubcracker_url')}    ${angvar('clubcracker_browser')}
    Maximize Browser Window
    Handle Pop-up
    Sleep    2
    Log    Browser opened successfully

HomePage_menu_image_loading
    
    # Step 1: Wait until the element is visible
    Wait Until Element Is Visible    xpath:(//div[@class='content_wrapper'])[3]    60s
    Sleep    2
    ${menu_1}=    Run Keyword And Return Status    Element Should Be Visible    xpath://a[text()='${con_1}']
    ${menu_2}=    Run Keyword And Return Status    Element Should Be Visible    xpath://a[text()='${con_2}']
    ${menu_3}=    Run Keyword And Return Status    Element Should Be Visible    xpath://span[text()='${con_3}']
    ${menu_4}=    Run Keyword And Return Status    Element Should Be Visible    xpath://span[text()='${con_4}']
    
    IF    ${menu_1}
        Log    "Our Food is visible."
        IF    ${menu_2} 
            Log    "Recipes is also visible."
            IF    ${menu_3}
                Log    "Where to Buy is also visible."
                IF    ${menu_4}
                    Log    "Contact Us is also visible."
                ELSE
                    Log    "Contact Us is NOT visible."
                END
            ELSE
                Log    "Where to Buy is NOT visible."
            END
        ELSE
            Log    "Recipes is NOT visible."
        END
    ELSE
        Log    "Our Food is NOT visible."
    END
    
    ${scroll_page} =    Run Keyword And Return Status    Element Should Be Visible    xpath:(//div[@class='content_wrapper'])[3]
    IF    ${scroll_page}
        Execute Javascript    window.scrollTo(0, 600)
        Log    "Scrolled down successfully."
        Sleep    1
        
        ${Product_image} =    Run Keyword And Return Status    Element Should Be Visible    xpath://h2[text()='Our Food']/following-sibling::div
        IF    ${Product_image}
            Wait Until Element Is Visible    xpath://h2[text()='Our Food']/following-sibling::div    60s
            Log    "Product image element is visible."
            
            ${screenshot} =    Run Keyword And Return Status    Element Should Be Visible    xpath://h2[text()='Our Food']/following-sibling::div
            IF    ${screenshot}
                Capture Element Screenshot    xpath://h2[text()='Our Food']/following-sibling::div
                Log    "Screenshot captured successfully."
            ELSE
                Log    "Failed to capture screenshot as the product image element is not visible."
                Capture Page Screenshot
            END
        ELSE
            Log    "Product image element is not visible. Skipping screenshot capture."
            Capture Page Screenshot
        END
    ELSE
        Log    "Content wrapper is not visible. Cannot scroll."
        Capture Page Screenshot
    END
    Sleep    2
    Copy Images    ${OUTPUT_DIR}    ${angvar('vm_path_dir')}
    Sleep	1

Finish TestCase
    Close All Browsers

Handle Pop-up
    Wait Until Page Contains Element    ${BANNER_XPATH}    timeout=10
    ${actual_text}=    Get Text    ${BANNER_XPATH}
    Should Be Equal As Strings    ${actual_text}    ${EXPECTED_TEXT}
    Click Element    ${OK_BUTTON_XPATH}
    