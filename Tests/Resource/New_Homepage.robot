
*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Kellanova_Library.py
Library    string
Library    Collections
Library    OperatingSystem

*** Variables ***
${con_1}    Our Food
${con_2}    Recipes
${con_3}    where to buy
${con_4}    Contact Us
${file_path}    C:\\tmp\\Kellanova\\Home_Page.txt
 
${EXPECTED_TEXT}    Cookies On Our Website
${OK_BUTTON_XPATH}    //button[@id='onetrust-accept-btn-handler']
${BANNER_XPATH}       //div[@role='alertdialog' and @aria-describedby='onetrust-policy-text']//h3
 
${BUY_BUTTON}    //a[@aria-label='click to see where to buy']
 
*** Keywords ***
Start TestCase
    Log    Opening browser
    Open Browser    ${angvar('clubcracker_url')}    ${angvar('clubcracker_browser')}
    Maximize Browser Window
    Run Keyword And Ignore Error    Remove File    ${file_path}
    Handle Pop-up
    Sleep    2
    Log    Browser opened successfully
    Create File    ${file_path}
   
 
   
Homepage Menu
    # Step 1: Wait until the element is visible
    Wait Until Element Is Visible    xpath:(//div[@class='content_wrapper'])[3]    60s
    Sleep    2
    ${Logo_1}=    Run Keyword And Return Status    Element Should Be Visible    xpath://a[@class='header-logo track']//img[1]
    ${menu_1}=    Run Keyword And Return Status    Element Should Be Visible    xpath://a[text()='${con_1}']
    ${menu_2}=    Run Keyword And Return Status    Element Should Be Visible    xpath://a[text()='${con_2}']
    ${menu_3}=    Run Keyword And Return Status    Element Should Be Visible    xpath://span[text()='${con_3}']
    ${menu_4}=    Run Keyword And Return Status    Element Should Be Visible    xpath://span[text()='${con_4}']
    # ${Home_page_details}    Create List
    IF  ${Logo_1}  
        ${Logo_message}   Set Variable     PASS: Logo menu is Visible
        Log    ${Logo_message}
        Append To File    ${file_path}    ${Logo_message}\n
        IF    ${menu_1}
            ${Top_menu1}   Set Variable     PASS: Our Food menu is visible
            Log    ${Top_menu1}
            Append To File    ${file_path}    ${Top_menu1}\n
 
            IF    ${menu_2}
                ${Top_menu2}   Set Variable     PASS: Recipes menu is visible
                Log    ${Top_menu2}
                Append To File    ${file_path}    ${Top_menu1}\n
               
                IF    ${menu_3}
                    ${Top_menu3}   Set Variable     PASS: Where to Buy menu is visible
                    Log    ${Top_menu3}
                    Append To File    ${file_path}    ${Top_menu3}\n
 
                    IF    ${menu_4}
                        ${Top_menu4}   Set Variable     PASS: Contact Us menu is visible
                        Log    ${Top_menu4}
                        Append To File    ${file_path}    ${Top_menu4}\n
 
                       
                    ELSE
                        ${CONTACT_US_MESSAGE}    Set Variable    WARN: Contact Us is NOT visible.
                        Log    ${CONTACT_US_MESSAGE}
                        Append To File    ${file_path}    ${CONTACT_US_MESSAGE}\n
                    END
                ELSE
                    ${WHERE_TO_BUY_MESSAGE}    Set Variable    WARN: Where to Buy is NOT visible.
                    Log    ${WHERE_TO_BUY_MESSAGE}
                    Append To File    ${file_path}    ${WHERE_TO_BUY_MESSAGE}\n
                END
            ELSE
                ${RECIPES_MESSAGE}    Set Variable    WARN: Recipes is NOT visible.
                Log    ${RECIPES_MESSAGE}
                Append To File    ${file_path}    ${RECIPES_MESSAGE}\n
            END
        ELSE
            ${OUR_FOOD_MESSAGE}    Set Variable    WARN: Our Food is NOT visible.
            Log    ${OUR_FOOD_MESSAGE}
            Append To File    ${file_path}    ${OUR_FOOD_MESSAGE}\n
        END
    ELSE
 
        ${LOGO_MESSAGE}    Set Variable    WARN: Logo is NOT visible.
        Log    ${LOGO_MESSAGE}
        Append To File    ${file_path}    ${LOGO_MESSAGE}\n
    END
   
   
    #OUR FOOD
    ${OurProduct_topmenu}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:(//ul[@class='topmenu']//a)[1]    60s
    # ${Clicked_menu}    Create List
    IF    ${OurProduct_topmenu}
        Click Element    xpath:(//ul[@class='topmenu']//a)[1]
        Sleep    2
       
        ${product_link_ele}    Set Variable    PASS: Products link is visible.
        Log    ${product_link_ele}
        Append To File    ${file_path}    ${product_link_ele}\n
 
        ${is_products_list_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://div[@class='products-list-product']    60s
        IF    ${is_products_list_visible}
            ${products_list}    Set Variable    PASS: Successfully navigated to Products Items
            Log    ${products_list}
            Append To File    ${file_path}    ${products_list}\n
           
        ELSE
            ${product_list}    Set Variable    WARN: Products list not visible after navigation.
            Log     ${product_list}
            Append To File    ${file_path}    ${product_list}\n
        END
    ELSE
        ${product_link}    Set Variable    WARN: Products link not visible.
        Log    ${product_link}
        Append To File    ${file_path}    ${product_link}\n
    END
 
    # Recipes Navigation
   
    ${Recipes_topmenu}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:(//ul[@class='topmenu']//a)[2]    60s
    IF    ${Recipes_topmenu}
        Click Element    xpath:(//ul[@class='topmenu']//a)[2]
        Sleep    2
 
        ${recipes_link_el}    Set Variable    PASS: Recipes link is visible
        Log    ${recipes_link_el}
        Append To File    ${file_path}    ${recipes_link_el}\n
 
        ${is_recipes_list_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://div[@class='recipe-list']    60s
        IF    ${is_recipes_list_visible}
            ${recipes_list}    Set Variable    PASS: Successfully navigated to Recipes section.
            Log    ${recipes_list}
            Append To File    ${file_path}    ${recipes_list}\n
 
           
        ELSE
            ${recipes_product}    Set Variable    WARN: Recipes list not visible after navigation
            Log    ${recipes_product}
            Append To File    ${file_path}    ${recipes_product}\n
           
        END
    ELSE
        ${recipes_link}    Set Variable    WARN: Recipes link not visible
        Log    ${recipes_link}
        Append To File    ${file_path}    ${recipes_link}\n
       
    END
 
    # Where to Buy
   
    ${WheretoBuy_topmenu}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:(//a[@class='link--where-to-buy track'])[1]    60s
    IF    ${WheretoBuy_topmenu}
        Click Element    xpath:(//a[@class='link--where-to-buy track'])[1]
        Sleep    2
 
        ${Where to Buy_menu}    Set Variable    PASS: where to Buy button not visible
        Log    ${Where to Buy_menu}
        Append To File    ${file_path}    ${Where to Buy_menu}\n
 
        ${is_buy_select_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://label[@for='__ps-sku-selector-0_0']/following-sibling::select[1]    60s
        IF    ${is_buy_select_visible}
            Click Element    xpath://span[@data-ps-shift-tab='[data-ps-tab=".ps-lightbox-close"]']
            Sleep    2
            ${Where to Buy_el}    Set Variable    PASS: Select box is visible in 'Where to Buy' section
            Log    ${Where to Buy_el}
            Append To File    ${file_path}    ${Where to Buy_el}\n
 
           
        ELSE
            ${Where to Buy}    Set Variable    WARN: Select box not visible in 'Where to Buy' section
            Log    ${Where to Buy}
            Append To File    ${file_path}    ${Where to Buy}\n
           
        END
    ELSE
        ${Where to Buy_button}    Set Variable    WARN: Buy button not visible
        Log    ${Where to Buy_button}
        Append To File    ${file_path}    ${Where to Buy_button}\n
       
    END
 
    # Contact Us
    # Run Keyword And Ignore Error    Scroll Element Into View    xpath://div[contains(@class,'footer aem-GridColumn')]//footer[1]
    ${is_contact_us_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://span[normalize-space(text())='Contact Us']    60s
    IF    ${is_contact_us_visible}
        Click Element    xpath://span[normalize-space(text())='Contact Us']
        Sleep    2
 
        ${Contact Us_vis}    Set Variable    PASS: Contact Us link is visible
        Log    ${Contact Us_vis}
        Append To File    ${file_path}    ${Contact Us_vis}\n
 
        ${is_contact_section_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:(//section[@class='section--in-viewport'])[2]    10s
        IF    ${is_contact_section_visible}
 
            ${contact_section}    Set Variable    PASS: Successfully navigated to Contact Us section
            Log    ${contact_section}
            Append To File    ${file_path}    ${contact_section}\n
 
           
        ELSE
            ${Contact Us_button}    Set Variable    WARN: Contact Us section not visible after navigation
            Log    ${Contact Us_button}
            Append To File    ${file_path}    ${Contact Us_button}\n
           
        END
    ELSE
        ${Contact Us_link}    Set Variable    WARN: Contact Us link not visible
        Log    ${Contact Us_link}
        Append To File    ${file_path}    ${Contact Us_link}\n
       
    END
    # Log    ${file_path}
    # Set Global Variable    ${file_path}
    # Log To Console    **gbStart**check_menu**splitKeyValue**${file_path}**gbEnd**
 
    Click Element    xpath://a[@class='header-logo track']//img[1]
    Sleep    2
    Wait Until Element Is Visible    xpath:(//div[@class='rich-text'])[1]    60s
    Sleep    2
 
 
    ${product_page} =    Run Keyword And Return Status    Element Should Be Visible    xpath:(//div[@class='content_wrapper'])[3]
    IF    ${product_page}
        # Scroll Element Into View    xpath://h2[text()='Our Food']/following-sibling::div
        Execute Javascript    window.scrollTo(0, 600)
        Sleep    2
        # Log    "Scrolled down successfully"
        Sleep    1
 
        ${product_count}=    Get Element Count    xpath://div[@class='products-list-product']
        Log    Total products found: ${product_count}
 
   
        ${Product_image} =    Run Keyword And Return Status    Element Should Be Visible    xpath://h2[text()='Our Food']/following-sibling::div
        IF    ${Product_image}
            Wait Until Element Is Visible    xpath://h2[text()='Our Food']/following-sibling::div    60s
           
            ${prod_image}    Set Variable    PASS: Product image element is visible
            Log    ${prod_image}
            Append To File    ${file_path}    ${prod_image}\n
           
            ${screenshot} =    Run Keyword And Return Status    Element Should Be Visible    xpath://h2[text()='Our Food']/following-sibling::div
            IF    ${screenshot}
                Capture Element Screenshot    xpath://h2[text()='Our Food']/following-sibling::div
                Sleep    2
                Log    "Screenshot captured successfully."
            ELSE
                Log    "Failed to capture screenshot as the product image element is not visible."
                Capture Page Screenshot
            END
        ELSE
            ${prod_image}    Set Variable    WARN: Product image element is not visible
            Log    ${prod_image}
            Append To File    ${file_path}    ${prod_image}\n
            Capture Page Screenshot
        END
    ELSE
        Log    "Content wrapper is not visible. Cannot scroll."
        Capture Page Screenshot
    END
    Sleep    2
 
    # Log    ${file_path}
    # Set Global Variable    ${file_path}
    # Log To Console    **gbStart**check_menu**splitKeyValue**${file_path}**gbEnd**
 
Homepage CTA
    Go To    https://www.clubcrackers.com/en_US/home.html
    Sleep    2
    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://img[@alt='Club Crackers']    60s
    Sleep    2
 
    # 1ST_CTA
    ${is_img_visible}=    Run Keyword And Return Status    Element Should Be Visible    xpath://img[@alt='Club Crackers']
    # ${file_path}    Create List
    IF    ${is_img_visible}
        Click Element    xpath://img[@alt='Club Crackers']
        Sleep    2
        Wait Until Element Is Visible    xpath:(//div[@class='content_wrapper'])[3]    60s
        Click Element    xpath:(//a[@class='button-cta track'])[1]
        Sleep    2
        Wait Until Element Is Visible     xpath://a[contains(@class,'button-cta button-cta-red')]    60s
        Sleep    2
        Capture Page Screenshot
        ${first_CTA_1}    Set Variable    PASS: explore_sweet_hawaiian is Visible
        Log    ${first_CTA_1}
        Append To File    ${file_path}    ${first_CTA_1}\n
    ELSE
        ${first_CTA_2}    Set Variable    WARN: explore_sweet_hawaiian is not Visible
        Log    ${first_CTA_2}
        Append To File    ${file_path}    ${first_CTA_2}\n
         
    END
   
    #2nd_CTA
    Click Element    xpath://img[@alt='Club Crackers']
    Sleep    2
    Wait Until Element Is Visible    xpath:(//div[@class='content_wrapper'])[3]    60s
    Click Element    xpath://button[@data-controls='next']
    Sleep    2
 
    ${2nd_CTA}=    Run Keyword And Return Status    Element Should Be Visible    xpath:(//div[contains(@class,'hero-slide hero-slide--need')]//div)[1]
    IF    ${2nd_CTA}
       
        Click Element    xpath:(//a[@class='button-cta track'])[2]
        Sleep    2
        Wait Until Element Is Visible     xpath://a[contains(@class,'button-cta button-cta-red')]    60s
        Sleep    2
        Capture Page Screenshot
 
        ${second _CTA_1}    Set Variable    PASS: Explore original is visible
        Log    ${second _CTA_1}
        Append To File    ${file_path}    ${second _CTA_1}\n
    ELSE
        ${second _CTA_2}    Set Variable    WARN: Explore original is not visible
        Log    ${second _CTA_2}
        Append To File    ${file_path}    ${second _CTA_2}\n
         
    END
   
    #3RD_CTA
    Click Element    xpath://img[@alt='Club Crackers']
    Sleep    2
    Wait Until Element Is Visible    xpath:(//div[@class='content_wrapper'])[3]    60s
    Click Element    xpath://button[@data-controls='next']
    Sleep    2
    Wait Until Element Is Visible    xpath:(//div[contains(@class,'hero-slide hero-slide--need')]//div)[1]    60s
    Click Element    xpath://button[@data-controls='next']
    Sleep    2
 
    ${3RD_CTA}=    Run Keyword And Return Status    Element Should Be Visible    xpath:(//div[@id='tns1-item2']//div)[1]    50s
    IF    ${3RD_CTA}
       
        Click Element    xpath:(//a[@class='button-cta track'])[3]
        Sleep    2
        Wait Until Element Is Visible     xpath://a[contains(@class,'button-cta button-cta-red')]    60s
        Sleep    2
        Capture Page Screenshot
 
        ${third_CTA_1}    Set Variable    PASS: Explore original is visible
        Log    ${third_CTA_1}
        Append To File    ${file_path}    ${third_CTA_1}\n
    ELSE
        ${third_CTA_2}    Set Variable    WARN: 2nd Explore original is not visible
        Log    ${third_CTA_2}
        Append To File    ${file_path}    ${third_CTA_2}\n
         
    END
 
    # 4th_CTA
    Click Element    xpath://img[@alt='Club Crackers']
    Sleep    2
    Wait Until Element Is Visible    xpath:(//div[@class='content_wrapper'])[3]    60s
    Click Element    xpath://button[@data-controls='next']
    Sleep    2
    Click Element    xpath://button[@data-controls='next']
    Sleep    2
    Click Element    xpath://button[@data-controls='next']
    Sleep    2
 
    ${4th_CTA}=    Run Keyword And Return Status    Element Should Be Visible    xpath:(//div[contains(@class,'hero-slide hero-slide--mfs')]//div)[1]
    IF    ${4th_CTA}
       
        Click Element    xpath:(//a[@class='button-cta track'])[4]
        Sleep    2
        Wait Until Element Is Visible     xpath://a[contains(@class,'button-cta button-cta-red')]    60s
        Sleep    2
        Capture Page Screenshot
 
        ${forth_CTA_1}    Set Variable    PASS: Explore minis is visible
        Log    ${forth_CTA_1}
        Append To File    ${file_path}    ${forth_CTA_1}\n
    ELSE
        ${forth_CTA_2}    Set Variable    WARN: Explore minis is not visible
        Log    ${forth_CTA_2}
        Append To File    ${file_path}    ${forth_CTA_2}\n
         
    END
 
    #5th_CTA
    Click Element    xpath://img[@alt='Club Crackers']
    Sleep    2
    Wait Until Element Is Visible    xpath:(//div[@class='content_wrapper'])[3]    60s
    Run Keyword And Ignore Error    Scroll Element Into View    xpath://div[@class='promotions-featured-row']//a[1]
    Sleep    2
    ${5th_CTA}=    Run Keyword And Return Status    Element Should Be Visible    xpath://div[@class='promotions-featured-row']//a[1]
    IF    ${5th_CTA}
       
        Click Element    xpath:(//span[@class='button-cta'])[1]
        Sleep    2
        Wait Until Element Is Visible     xpath://div[@class='recipe-list']    60s
        Capture Page Screenshot
 
        ${fifth_CTA_1}    Set Variable    PASS: Checkout our recipes is visible
        Log    ${fifth_CTA_1}
        Append To File    ${file_path}    ${fifth_CTA_1}\n
    ELSE
        ${fifth_CTA_2}    Set Variable    WARN: Checkout our recipes is not visible
        Log    ${fifth_CTA_2}
        Append To File    ${file_path}    ${fifth_CTA_2}\n
         
    END
 
    #6th_CTA
    Click Element    xpath://img[@alt='Club Crackers']
    Sleep    2
    Wait Until Element Is Visible    xpath:(//div[@class='content_wrapper'])[3]    60s
    Run Keyword And Ignore Error    Scroll Element Into View    xpath://div[@class='promotions-featured-row']//a[2]
    Sleep    2
    ${6th_CTA}=    Run Keyword And Return Status    Element Should Be Visible    xpath://div[@class='promotions-featured-row']//a[2]
    IF    ${6th_CTA}
       
        Click Element    xpath:(//span[@class='button-cta'])[2]
        Sleep    2
        Switch Window    new
        Sleep    5
        ${sixth_CTA_1}    Set Variable    PASS: keep up with club on instagram is not visible
        Log    ${sixth_CTA_1}
        Append To File    ${file_path}    ${sixth_CTA_1}\n
 
        Switch Window    main
    ELSE
        ${sixth_CTA_2}    Set Variable    WARN: keep up with club on instagram is not visible
        Log    ${sixth_CTA_2}
        Append To File    ${file_path}    ${sixth_CTA_2}\n
         
    END
    # Log    ${file_path}
    # Set Global Variable    ${file_path}
    # Log To Console    **gbStart**check_CTA**splitKeyValue**${file_path}**gbEnd**
Homepage Footer
     
    Go To    https://www.clubcrackers.com/en_US/home.html
    Sleep    2
    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://img[@alt='Club Crackers']    60s
    Sleep    2
   
    # Home Navigation
    Run Keyword And Ignore Error    Scroll Element Into View    xpath://div[contains(@class,'footer aem-GridColumn')]//footer[1]
    ${is_footer_home_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://a[@data-tracking='footer|nav|footer-home']    60s
    # ${file_path}    Create List
    IF    ${is_footer_home_visible}
        Click Element    xpath://a[@data-tracking='footer|nav|footer-home']
        Sleep    2
 
        ${home_1}    Set Variable    PASS: Footer Home link is visible
        Log    ${home_1}
        Append To File    ${file_path}    ${home_1}\n
 
        ${is_club_img_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://img[@alt='Club Crackers']    60s
        IF    ${is_club_img_visible}
            Capture Page Screenshot
           
            ${club_image_1}    Set Variable    PASS: Club Crackers image is visible after navigation
            Log    ${club_image_1}
            Append To File    ${file_path}    ${club_image_1}\n
        ELSE
            ${club_image_2}    Set Variable    WARN: Club Crackers image not visible after navigation
            Log    ${club_image_2}
            Append To File    ${file_path}    ${club_image_2}\n
           
        END
    ELSE
        ${home_2}    Set Variable    WARN: Footer Home link not visible
        Log    ${home_2}
        Append To File    ${file_path}    ${home_2}\n
       
    END
 
    # Recipes Navigation
    Run Keyword And Ignore Error    Scroll Element Into View    xpath://div[contains(@class,'footer aem-GridColumn')]//footer[1]
    ${is_recipes_link_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:(//a[@data-tracking='menu-nav|nav|recipes-link'])[2]    60s
    IF    ${is_recipes_link_visible}
        Click Element    xpath:(//a[@data-tracking='menu-nav|nav|recipes-link'])[2]
        Sleep    2
 
        ${Recipes_1}    Set Variable    PASS: Recipes link is visible
        Log    ${Recipes_1}
        Append To File    ${file_path}    ${Recipes_1}\n
 
        ${is_recipes_list_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://div[@class='recipe-list']    60s
        IF    ${is_recipes_list_visible}
            Capture Page Screenshot
           
            ${recipes_list_1}    Set Variable    PASS: Recipes list is visible after navigation.
            Log    ${recipes_list_1}
            Append To File    ${file_path}    ${recipes_list_1}\n
        ELSE
            ${recipes_list_2}    Set Variable    WARN: Recipes list is not visible after navigation.
            Log    ${recipes_list_2}
            Append To File    ${file_path}    ${recipes_list_2}\n
           
        END
    ELSE
        ${Recipes_2}    Set Variable    WARN: Recipes link not visible
        Log    ${Recipes_2}
        Append To File    ${file_path}    ${Recipes_2}\n
       
    END
 
    # Products Navigation
    Run Keyword And Ignore Error    Scroll Element Into View    xpath://div[contains(@class,'footer aem-GridColumn')]//footer[1]
    ${is_footer_products_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://a[@data-tracking='footer|nav|footer-products']    60s
    IF    ${is_footer_products_visible}
        Click Element    xpath://a[@data-tracking='footer|nav|footer-products']
        Sleep    2
 
        ${Products_1}    Set Variable    PASS: Products link is visible
        Log    ${Products_1}
        Append To File    ${file_path}    ${Products_1}\n
        ${is_products_list_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://div[@class='products-list-product']    60s
        IF    ${is_products_list_visible}
            Capture Page Screenshot
           
            ${products_list_1}    Set Variable    PASS: Products list is visible after navigation
            Log    ${products_list_1}
            Append To File    ${file_path}   ${products_list_1}\n
        ELSE
            ${products_list_2}    Set Variable    WARN: Products list is not visible after navigation
            Log    ${products_list_2}
            Append To File    ${file_path}   ${products_list_2}\n
           
        END
    ELSE
        ${Products_2}    Set Variable    WARN: Products link is not visible
        Log    ${Products_2}
        Append To File    ${file_path}    ${Products_2}\n
       
    END
 
    # Where to Buy
    Run Keyword And Ignore Error    Scroll Element Into View    xpath://div[contains(@class,'footer aem-GridColumn')]//footer[1]
    ${is_buy_btn_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    id:where-to-buy    60s
    IF    ${is_buy_btn_visible}
        Click Element    id:where-to-buy
        Sleep    2
 
        ${where_to_buy_1}    Set Variable    PASS: Where to Buy button is visible
        Log    ${where_to_buy_1}
        Append To File    ${file_path}    ${where_to_buy_1}\n
        ${is_buy_select_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://label[@for='__ps-sku-selector-0_0']/following-sibling::select[1]    60s
        IF    ${is_buy_select_visible}
            Capture Page Screenshot
            Click Element    xpath://span[@data-ps-shift-tab='[data-ps-tab=".ps-lightbox-close"]']
            Sleep    2
           
            ${buy_select_1}    Set Variable    PASS: Successfully checked 'Where to Buy' section
            Log    ${buy_select_1}
            Append To File    ${file_path}    ${buy_select_1}\n
        ELSE
            ${buy_select_2}    Set Variable    WARN: Select box not visible in 'Where to Buy' section
            Log    ${buy_select_2}
            Append To File    ${file_path}    ${buy_select_2}\n
           
        END
    ELSE
        ${where_to_buy_2}    Set Variable    WARN: Where to Buy button not visible
        Log    ${where_to_buy_2}
        Append To File    ${file_path}    ${where_to_buy_2}\n
       
    END
 
    # Site Map
    Run Keyword And Ignore Error    Scroll Element Into View    xpath://div[contains(@class,'footer aem-GridColumn')]//footer[1]
    ${is_sitemap_link_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://a[normalize-space(text())='Site Map']    10s
    IF    ${is_sitemap_link_visible}
        Click Element    xpath://a[normalize-space(text())='Site Map']
        Sleep    2
 
        ${site map_1}    Set Variable    PASS: Site Map link is visible
        Log    ${site map_1}
        Append To File    ${file_path}    ${site map_1}\n
 
        ${is_sitemap_list_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:(//div[contains(@class,'sitemapV2 aem-GridColumn')])[2]    60s
        IF    ${is_sitemap_list_visible}
            Capture Page Screenshot
           
            ${sitemap_list_1}    Set Variable    PASS: Successfully navigated to Site Map section
            Log    ${sitemap_list_1}
            Append To File    ${file_path}    ${sitemap_list_1}\n
        ELSE
            ${sitemap_list_2}    Set Variable    WARN: Site Map list not visible after navigation
            Log    ${sitemap_list_2}
            Append To File    ${file_path}    ${sitemap_list_2}\
           
        END
    ELSE
        ${site map_2}    Set Variable    WARN: Site Map link not visible
        Log    ${site map_2}
        Append To File    ${file_path}    ${site map_2}\n
       
    END
 
    # Contact Us
    Run Keyword And Ignore Error    Scroll Element Into View    xpath://div[contains(@class,'footer aem-GridColumn')]//footer[1]
    ${is_contact_us_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://a[@data-tracking='footer|nav|footer-contact-us']    60s
    IF    ${is_contact_us_visible}
        Click Element    xpath://a[@data-tracking='footer|nav|footer-contact-us']
        Sleep    2
        ${Contact_Us_1}    Set Variable    PASS: Contact Us link is visible
        Log    ${Contact_Us_1}
        Append To File    ${file_path}    ${Contact_Us_1}\n
 
        ${is_contact_section_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:(//section[@class='section--in-viewport'])[2]    10s
        IF    ${is_contact_section_visible}
            Capture Page Screenshot
           
            ${contact_section_1}    Set Variable    PASS: Successfully navigated to Contact Us section
            Log    ${contact_section_1}
            Append To File    ${file_path}    ${contact_section_1}\n
        ELSE
            ${contact_section_2}    Set Variable    WARN: Contact Us section not visible after navigation
            Log    ${contact_section_2}
            Append To File    ${file_path}    ${contact_section_2}\n
           
        END
    ELSE
        ${Contact_Us_2}    Set Variable    WARN: Contact Us link not visible
        Log    ${Contact_Us_2}
        Append To File    ${file_path}    ${Contact_Us_2}\n
       
    END
    # Log    ${footer_menu}
    # Log To Console    **gbStart**Footer_menu**splitKeyValue**${footer_menu}**gbEnd**
   
 
 
    Run Keyword And Ignore Error    Scroll Element Into View    xpath://div[contains(@class,'footer aem-GridColumn')]//footer[1]
    Sleep    2
    Wait Until Element Is Visible    xpath://div[contains(@class,'footer aem-GridColumn')]//footer[1]    60s
    Sleep    2
 
   
    # Navigate to Social Link 1
    ${social_link_1}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://div[@id='sociallinks']//a[1]    10s
    # ${footer_social}    Create List
    IF    ${social_link_1}
        Click Element    xpath://div[@id='sociallinks']//a[1]
        Sleep    2
        Switch Window    new
        Sleep    2
 
        ${f_book_1}    Set Variable    PASS: Facebook link is visible
        Log    ${f_book_1}
        Append To File    ${file_path}    ${f_book_1}\n
        ${facebook}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:(//input[@name='email'])[2]    10s
        IF    ${facebook}
            Capture Page Screenshot
           
            Wait Until Element Is Visible    xpath:(//input[@name='email'])[2]    60s
            Click Element    xpath://div[@aria-label='Close']
            Sleep    2
 
            ${f_email_1}    Set Variable    PASS: Email input is visible after clicked on Facebook
            Log    ${f_email_1}
            Append To File    ${file_path}    ${f_email_1}\n
        ELSE
            ${f_email_2}    Set Variable    WARN: Email input is not visible after clicked on Facebook
            Log    ${f_email_2}
            Append To File    ${file_path}    ${f_email_2}\n
           
        END
        Switch Window    main
        Sleep    2
    ELSE
        ${f_book_2}    Set Variable    WARN: Facebook link not visible
        Log    ${f_book_2}
        Append To File    ${file_path}    ${f_book_2}\n
       
    END
 
    # Navigate to Social Link 2
    ${social_link_2}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:(//div[@id='sociallinks']//a)[2]    10s
    IF    ${social_link_2}
        Click Element    xpath:(//div[@id='sociallinks']//a)[2]
        Sleep    5
        Switch Window    new
        Sleep    6
       
        Switch Window    main
        Sleep    2
        ${insta_1}    Set Variable    PASS: instagram link is visible
        Log    ${insta_1}
        Append To File    ${file_path}    ${insta_1}\n
    ELSE
        ${insta_2}    Set Variable    WARN: instagram link not visible
        Log    ${insta_2}
        Append To File    ${file_path}    ${insta_2}\n
       
    END
 
    # Navigate to Social Link 3
    ${social_link_3}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:(//div[@id='sociallinks']//a)[3]    10s
    IF    ${social_link_3}
        Click Element    xpath:(//div[@id='sociallinks']//a)[3]
        Sleep    2
        Switch Window    new
        Sleep    2
 
        ${y_tube_1}    Set Variable    PASS: youtube link is visible
        Log    ${y_tube_1}
        Append To File    ${file_path}    ${y_tube_1}\n
        ${youtube}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://div[@id='page-header-banner-sizer']/yt-image-banner-view-model[1]/img[1]    10s
        IF    ${youtube}
            Capture Page Screenshot
            
 
            ${youtube_ban_1}    Set Variable    PASS: YouTube banner is visible
            Log    ${youtube_ban_1}
            Append To File    ${file_path}    ${youtube_ban_1}\n
        ELSE
            ${youtube_ban_2}    Set Variable    WARN: YouTube banner is not visible
            Log    ${youtube_ban_2}
            Append To File    ${file_path}    ${youtube_ban_2}\n
           
        END
        Switch Window    main
        Sleep    2
    ELSE
        ${y_tube_2}    Set Variable    WARN: youtube link not visible
        Log    ${y_tube_2}
        Append To File    ${file_path}    ${y_tube_2}\n
       
    END
 
    # Navigate to Pinterest
    ${social_link_4}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:(//a[@data-tracking='socialLinks|linkout|pinterest'])[2]    10s
    IF    ${social_link_4}
        Click Element    xpath:(//a[@data-tracking='socialLinks|linkout|pinterest'])[2]
        Sleep    2
        Switch Window    new
        Sleep    2
 
        ${pint_1}    Set Variable    PASS: Pinterest link is visible
        Log    ${pint_1}
        Append To File    ${file_path}    ${pint_1}\n
        ${pinterest}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://img[@alt='Club Crackers']    10s
        IF    ${pinterest}
            Capture Page Screenshot
           
            ${pint_img_1}    Set Variable    PASS: Pinterest image is visible
            Log    ${pint_img_1}
            Append To File    ${file_path}    ${pint_img_1}\n
        ELSE
            ${pint_img_2}    Set Variable    WARN: Pinterest image is not visible
            Log    ${pint_img_2}
            Append To File    ${file_path}    ${pint_img_2}\n
           
        END
        Switch Window    main
        Sleep    2
    ELSE
        ${pint_2}    Set Variable    WARN: Pinterest link is not visible
        Log    ${pint_2}
        Append To File    ${file_path}    ${pint_2}\n
       
    END
 
    # Navigate to Twitter
    ${social_link_5}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:(//a[@data-tracking='socialLinks|linkout|twitter'])[2]    10s
    IF    ${social_link_5}
        Click Element    xpath:(//a[@data-tracking='socialLinks|linkout|twitter'])[2]
        Sleep    2
        Switch Window    new
 
        ${twit_1}    Set Variable    PASS: Twitter link is visible
        Log    ${twit_1}
        Append To File    ${file_path}    ${twit_1}\n
        ${twitter}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath:(//div[@data-viewportview='true']//div)[1]    10s
        IF    ${twitter}
            Wait Until Element Is Visible    xpath:(//div[@data-viewportview='true']//div)[1]    60s
            Capture Page Screenshot
            # Click Element    xpath:(//button[@type='button']//div)[1]
            Sleep    2
 
            ${twit_view_1}    Set Variable    PASS: Twitter viewport is visible
            Log    ${twit_view_1}
            Append To File    ${file_path}    ${twit_view_1}\n
        ELSE
            ${twit_view_2}    Set Variable    WARN: Twitter viewport is not visible
            Log    ${twit_view_2}
            Append To File    ${file_path}    ${twit_view_2}\n
           
        END
        Switch Window    main
        Sleep    2
    ELSE
        ${twit_2}    Set Variable    WARN: Twitter link not visible
        Log    ${twit_2}
        Append To File    ${file_path}    ${twit_2}\n
       
    END
    # Log    ${footer_social}
    # Log To Console    **gbStart**Footer_social_link**splitKeyValue**${footer_social}**gbEnd**
 
    Run Keyword And Ignore Error    Scroll Element Into View    xpath://div[contains(@class,'footer aem-GridColumn')]//footer[1]
    Wait Until Element Is Visible    xpath://div[contains(@class,'footer aem-GridColumn')]//footer[1]    60s
 
   
 
    # Step 1: Validate and click the first link
    Wait Until Element Is Visible    xpath:(//ul[@id='lowerfooterlinks']//a)[1]    60s
    ${Link_1}=    Run Keyword And Return Status    Element Should Be Visible    xpath:(//ul[@id='lowerfooterlinks']//a)[1]
    # ${footer_all_link}    Create List
    IF    ${Link_1}    
        Click Element    xpath:(//ul[@id='lowerfooterlinks']//a)[1]
        Sleep    2
        Wait Until Element Is Visible    xpath://div[@role='alertdialog']    60s
        Capture Page Screenshot
        Click Element    xpath://button[@aria-label='Close']
        Sleep    2
       
 
        ${cookies_1}    Set Variable    PASS: Cookie Preferences is visible
        Log    ${cookies_1}
        Append To File    ${file_path}    ${cookies_1}\n
    ELSE  
        ${cookies_2}    Set Variable    WARN: Cookie Preferences is not visible
        Log    ${cookies_2}
        Append To File    ${file_path}    ${cookies_2}\n
       
    END
    # Step 2: Validate and click the second link
    Wait Until Element Is Visible    xpath:(//ul[@id='lowerfooterlinks']//a)[2]    60s
    ${Link_2}=    Run Keyword And Return Status    Element Should Be Visible    xpath:(//ul[@id='lowerfooterlinks']//a)[2]
    IF    ${Link_2}    
        Click Element    xpath:(//ul[@id='lowerfooterlinks']//a)[2]
        Sleep    2
        Switch Window    new
        Sleep    2
 
        ${P_notice_1}    Set Variable    PASS: Privacy Notice link is visible
        Log    ${P_notice_1}
        Append To File    ${file_path}    ${P_notice_1}\n
        ${privacy_notice}=    Run Keyword And Return Status    Element Should Be Visible    xpath://div[@id='otnotice-4fccfc07-c99f-4fed-96dd-27de30836495']/div[1]
        IF  ${privacy_notice}
            # Wait Until Element Is Visible    xpath://div[@id='otnotice-4fccfc07-c99f-4fed-96dd-27de30836495']/div[1]    60s
            Run Keyword And Ignore Error    Wait Until Keyword Succeeds    30s   2s    Click Element    locator=id:onetrust-accept-btn-handler
            Sleep    1
            Capture Page Screenshot
            Sleep    2
 
            ${P_notice_page}    Set Variable    PASS: Privacy Notice page is visible
            Log    ${P_notice_page}
            Append To File    ${file_path}    ${P_notice_page}\n
        END
        Switch Window    main
        Sleep    2
       
    ELSE    
        ${P_notice_2}    Set Variable    WARN: Privacy Notice link is not visible
        Log    ${P_notice_2}
        Append To File    ${file_path}    ${P_notice_2}\n
       
    END
 
    # Step 3: Validate and click the third link
    Wait Until Element Is Visible    xpath:(//ul[@id='lowerfooterlinks']//a)[3]    60s
    ${Link_3}=    Run Keyword And Return Status    Element Should Be Visible    xpath:(//ul[@id='lowerfooterlinks']//a)[3]
    IF    ${Link_3}    
        Click Element    xpath:(//ul[@id='lowerfooterlinks']//a)[3]
        Sleep    2
        Switch Window    new
        Sleep    2
 
        ${privacy_1}    Set Variable    PASS: US Privacy link is visible
        Log    ${privacy_1}
        Append To File    ${file_path}    ${privacy_1}\n
        ${us_privacy}=    Run Keyword And Return Status    Element Should Be Visible    xpath:(//section[@class='otnotice-section'])[1]
        IF  ${us_privacy}
            # Wait Until Element Is Visible    xpath:(//section[@class='otnotice-section'])[1]    60s
            Sleep    2
            Capture Page Screenshot
 
            ${privacy_page}    Set Variable    PASS: US Privacy page is visible
            Log    ${privacy_page}
            Append To File    ${file_path}    ${privacy_page}\n
        END
        Switch Window    main
        Sleep    2
       
    ELSE    
        ${privacy_2}    Set Variable    WARN: US Privacy link is not visible
        Log    ${privacy_2}
        Append To File    ${file_path}    ${privacy_2}\n
       
    END
 
    # Step 4: Validate and click the fourth link
    Wait Until Element Is Visible    xpath:(//ul[@id='lowerfooterlinks']//a)[4]    60s
    ${Link_4}=    Run Keyword And Return Status    Element Should Be Visible    xpath:(//ul[@id='lowerfooterlinks']//a)[4]
    IF    ${Link_4}    
        Click Element    xpath:(//ul[@id='lowerfooterlinks']//a)[4]
        Sleep    2
        Switch Window    new
        Sleep    2
 
        ${terms_use_1}    Set Variable    PASS: Terms of Use link is visible
        Log    ${terms_use_1}
        Append To File    ${file_path}    ${terms_use_1}\n
        ${Terms_of_use}=    Run Keyword And Return Status    Element Should Be Visible    xpath:(//div[@class='otnotice']//div)[1]
        IF  ${Terms_of_use}
            # Wait Until Element Is Visible    xpath:(//div[@class='otnotice']//div)[1]    60s
            Sleep    2
            Capture Page Screenshot
           
            ${terms_use_page}    Set Variable    PASS: Terms of Use page is visible
            Log    ${terms_use_page}
            Append To File    ${file_path}    ${terms_use_page}\n
           
        END
        Switch Window    main
        Sleep    2
       
    ELSE    
        ${terms_use_2}    Set Variable    WARN: Terms of Use link is not visible
        Log    ${terms_use_2}
        Append To File    ${file_path}    ${terms_use_2}\n
       
    END
    # Step 5: Validate and click the fifth link
    Wait Until Element Is Visible    xpath:(//ul[@id='lowerfooterlinks']//a)[5]    60s
    ${Link_5}=    Run Keyword And Return Status    Element Should Be Visible    xpath:(//ul[@id='lowerfooterlinks']//a)[5]
    IF    ${Link_5}    
        Click Element    xpath:(//ul[@id='lowerfooterlinks']//a)[5]
        Sleep    2
        Switch Window    new
        Sleep    2
 
        ${Accessibility_link_1}    Set Variable    PASS: Accessibility link is visible
        Log    ${Accessibility_link_1}
        Append To File    ${file_path}    ${Accessibility_link_1}\n
        ${Accessibility}=    Run Keyword And Return Status    Element Should Be Visible    xpath:(//div[@class='otnotice']//div)[1]
        IF  ${Accessibility}
            # Wait Until Element Is Visible    xpath:(//div[@class='otnotice']//div)[1]    60s
            Sleep    2
            Capture Page Screenshot
           
            ${Accessibility_link_page}    Set Variable    PASS: Accessibility page is visible
            Log    ${Accessibility_link_page}
            Append To File    ${file_path}    ${Accessibility_link_page}\n
        END
        Switch Window    main
        Sleep    2
       
    ELSE    
        ${Accessibility_link_2}    Set Variable    WARN: Accessibility link is not visible
        Log    ${Accessibility_link_2}
        Append To File    ${file_path}    ${Accessibility_link_2}\n    
       
    END
    # Step 6: Validate and click the sixth link
    Wait Until Element Is Visible    xpath:(//ul[@id='lowerfooterlinks']//a)[6]    60s
    ${Link_6}=    Run Keyword And Return Status    Element Should Be Visible    xpath:(//ul[@id='lowerfooterlinks']//a)[6]
    IF    ${Link_6}  
        Click Element    xpath:(//ul[@id='lowerfooterlinks']//a)[6]
        Sleep    2
        Switch Window    new
        Sleep    2
 
        ${Privacy Choices_1}    Set Variable    PASS: Your Privacy Choices is visible
        Log    ${Privacy Choices_1}
        Append To File    ${file_path}    ${Privacy Choices_1}\n
        ${Persnoal_information}=    Run Keyword And Return Status    Element Should Be Visible    xpath:(//div[@class='otnotice']//div)[1]
        IF  ${Persnoal_information}
            Wait Until Element Is Visible    xpath:(//div[@class='otnotice']//div)[1]    60s
            Sleep    2
            Capture Page Screenshot
           
            ${Privacy Choices_page}    Set Variable    PASS: Your Privacy Choices page is visible
            Log    ${Privacy Choices_page}
            Append To File    ${file_path}    ${Privacy Choices_page}\n
        END
        Switch Window    main
        Sleep    2
       
    ELSE    
        ${Privacy Choices_2}    Set Variable    WARN: Your Privacy Choices is not visible
        Log    ${Privacy Choices_2}
        Append To File    ${file_path}    ${Privacy Choices_2}\n
       
    END
    Copy Images    ${OUTPUT_DIR}    ${angvar('vm_path_dir')}
    Sleep   1

    ${local}    Extract And Txt    ${file_path}
    Log To Console    **gbStart**HomePage_Result**splitKeyValue**${local}**gbEnd**
    Generate Report Html    input_file=${file_path}    output_file=C:\\tmp\\Kellanova\\Home_Page_New.html    report_name=Home Page Report
    Sleep    2
   
 
Handle Pop-up
    Wait Until Page Contains Element    ${BANNER_XPATH}    timeout=10
    ${actual_text}=    Get Text    ${BANNER_XPATH}
    Should Be Equal As Strings    ${actual_text}    ${EXPECTED_TEXT}
    Click Element    ${OK_BUTTON_XPATH}