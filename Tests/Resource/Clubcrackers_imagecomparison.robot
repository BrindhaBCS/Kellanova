*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    String
*** Variables ***
${URL}    ${angvar('clubcracker_url')}
${Browser}    ${angvar('clubcracker_browser')}
*** Keywords ***
Imagecomparison
    Open Browser    url=${URL}    browser=${Browser}    options=add_argument("--ignore-certificate-errors")
    Maximize Browser Window
    Click Element    locator=xpath://a[text()="Our Food"]
    Sleep    1
    ${product_count}=    Get Element Count    xpath://div[@class='products-list-product']
    Log    Total products found: ${product_count}
        FOR    ${index}    IN RANGE    1    ${product_count + 1}
            ${a}    Run Keyword And Return Status    Page Should Contain Element    locator=xpath:(//div[@class='product-list-title bvValues'])[${index}]
            IF  '${a}' == 'True'
                Scroll Element Into View    locator=xpath:(//div[@class='product-list-title bvValues'])[${index}]
                Sleep    2
                ${CLEANED_TEXT}    Get Text    locator=xpath:(//div[@class='product-list-title bvValues'])[${index}]
                Capture Element Screenshot    locator=xpath:(//div[@class='product-primary-image'])[${index}]    filename=C:\\kellaova\\catalogimage\\${index}_catalogimage_${CLEANED_TEXT}.png
                Sleep    2
                Click Element    locator=xpath:(//div[@class='product-list-title bvValues'])[${index}]
                Wait Until Element Is Visible    locator=xpath://div[@class='product-slider-aspect-ratio']//img[1]    timeout=30s
                Capture Element Screenshot    locator=xpath://div[@class='product-slider-aspect-ratio']//img[1]    filename=C:\\kellaova\\productimage\\${index}_productimage_${CLEANED_TEXT}.png
                Sleep    5
                Click Element    locator=xpath:(//a[@aria-label='click to see where to buy'])[1]
                Wait Until Element Is Visible    locator=xpath://div[@class='ps-product-image inline']//img[1]    timeout=30s
                Capture Element Screenshot    locator=xpath://div[@class='ps-product-image inline']//img[1]    filename=C:\\kellaova\\wheretobuy\\${index}_wheretobuy_${CLEANED_TEXT}.png
                Sleep    1
                Go Back
                Sleep    1
                
            END
        END