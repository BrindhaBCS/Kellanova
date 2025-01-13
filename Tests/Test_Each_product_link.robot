*** Settings ***
Resource    ../Tests/Resources/Each_product_link.robot
Suite Setup    Each_product_link.Start TestCase
Suite Teardown    Each_product_link.Finish TestCase
Test Tags    Each_product

*** Test Cases ***

Products should load on Product Pages
    Products should load on Product Pages 