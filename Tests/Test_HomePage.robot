*** Settings ***
Resource    ../Tests/Resource/HomePage.robot
Suite Setup    HomePage.Start TestCase
Test Tags    HomePage

*** Test Cases ***
Homepage Menu
	Homepage Menu
Homepage CTA
    Homepage CTA
Homepage Footer 
    Homepage Footer 