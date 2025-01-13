*** Settings ***
Resource    ../Tests/Resource/Club_Logo.robot
Suite Setup    Club_Logo.Browser
Test Tags    Club_Logo
*** Test Cases ***
Usecase
    Response_check
    Page_title
    Logo_contains
