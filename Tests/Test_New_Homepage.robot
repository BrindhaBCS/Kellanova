*** Settings ***
Resource    ../Tests/Resource/New_Homepage.robot
Suite Setup    New_Homepage.Start TestCase
Test Tags    New_Home_page

*** Test Cases ***
Homepage Menu
	Homepage Menu
Homepage CTA
    Homepage CTA
Homepage Footer 
    Homepage Footer