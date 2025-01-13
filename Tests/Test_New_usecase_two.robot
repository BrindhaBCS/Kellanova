*** Settings ***
Resource    ../Tests/Resource/New_usecase_two.robot
Suite Setup    New_usecase_two.Browser
Test Tags    New_use_case_two
*** Test Cases ***
Usecase
    Response_check
    Page_title
    Our_Food_Menu