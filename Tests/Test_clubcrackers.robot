*** Settings ***
Resource    ../Tests/Resource/clubcrackers.robot
Suite Setup    clubcrackers.Start TestCase
Suite Teardown    clubcrackers.Finish TestCase
Test Tags    clubcracker

*** Test Cases ***


HomePage_menu_image_loading
    HomePage_menu_image_loading