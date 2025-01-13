*** Settings ***
Resource    ../Tests/Resource/usecase_two_club.robot
Suite Setup    usecase_two_club.Browser
Test Tags    Club_usecasetwo
*** Test Cases ***
Usecase
    Response_check
    Page_title
    Our_Food_Menu