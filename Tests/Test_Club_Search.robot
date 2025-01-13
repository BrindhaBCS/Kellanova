*** Settings ***
Resource    ../Tests/Resource/Club_Search.robot
Suite Setup    Club_Search.Browser
Test Tags    Club_Search
*** Test Cases ***
Usecase
    Response_check
    Page_title
    search_icon