*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${LOGIN}
${PASSWORD}
${TRACKNUMBER}    JJFI234567890
${LOGIN URL}      https://www.posti.fi/en/private/omaposti?
${BROWSER}        Chrome
${FILTER}         //*[@id="feed_filter_activating_button"]
${COOKIES}        //*[@id="onetrust-banner-sdk"]/div
${TRACK}          //*[@id="actionToolbarTrack"]
${OPTIONS}        //*[@id="options-button"]
${INVOICE}        //*[@id="actionToolbarAdd"]
${FIRSTELEMENT}   //*[@id="layout_column"]/div/section[1]/div[2]/div/div/div/article[2]
*** Test Cases ***
Oma Posti Verifications
    Open Browser To Posti Main Page
    Accept Cookies
    Click Oma Posti
    Input Username
    Input Password
    Login
    Filter Letters
    Filter Parcels
    Filter Invoices
    Filter All
    Archive And Unarchive
    Add And Delete Item
    Add And Delete Invoice
    Nearest Posti
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Posti Main Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    OmaPosti – Private – Posti

Accept Cookies
    Wait Until Element Is Visible   ${COOKIES}
    Click Element    //*[@id="onetrust-reject-all-handler"]

Click Oma Posti
    Click Element   //*[@id="posti-fi-navigation"]/div[1]/div/div[2]/div/button
    Wait Until Element Is Visible    //*[@id="posti-fi-navigation"]/div[2]/div/div/a[1]
    Click Element    //*[@id="posti-fi-navigation"]/div[2]/div/div/a[1]
    Wait Until Element Is Visible    //*[@id="login"]/div[3]/div/form/p/div[1]

Input Username
    Input Text    username    ${LOGIN}

Input Password
    Input Text    password    ${PASSWORD}

Login
    Click Element    //*[@id="login"]/div[3]/div/form/div
    Wait Until Element Is Visible    //*[@id="feed_filter_activating_button"]
    Element Should Be Visible    //*[@id="feed_filter_activating_button"]

Filter Letters
    Click Element    ${FILTER}
    Click Element    //*[@id="feedHeaderContainer"]/div[2]/div/div/div/ul/li[3]
    Element Should Be Visible    ${FIRSTELEMENT}

Filter Parcels
    Click Element    ${FILTER}
    Click Element    //*[@id="feedHeaderContainer"]/div[2]/div/div/div/ul/li[4]
    Element Should Be Visible    ${FIRSTELEMENT}

Filter Invoices
    Click Element    ${FILTER}
    Click Element    //*[@id="feedHeaderContainer"]/div[2]/div/div/div/ul/li[2]
    Element Should Be Visible    ${FIRSTELEMENT}

Filter All
    Click Element    ${FILTER}
    Click Element    //*[@id="feedHeaderContainer"]/div[2]/div/div/div/ul/li[1]
    Element Should Be Visible    ${FIRSTELEMENT}

Archive and Unarchive
    Click Element    ${FIRSTELEMENT}
    Wait Until Element Is Visible    ${OPTIONS}
    Click Element    ${OPTIONS}
    Wait Until Element Is Visible    //*[@id="options-menu"]/li[2]
    Click Element    //*[@id="options-menu"]/li[2]
    Click Element    //*[@id="navMenuOmaPosti"]/ul/li[2]
    Wait Until Element Is Visible    ${FIRSTELEMENT}
    Click Element    ${FIRSTELEMENT}
    Wait Until Element Is Visible    ${OPTIONS}
    Click Element    ${OPTIONS}
    Wait Until Element Is Visible    //*[@id="options-menu"]/li[1]
    Click Element    //*[@id="options-menu"]/li[1]
    Click Element    //*[@id="navMenuOmaPosti"]/ul/li[1]
    Wait Until Element Is Visible    ${FIRSTELEMENT}

Add And Delete Item
     Click Element    ${TRACK}
    Wait Until Element Is Visible    //*[@id="pageParcelTracking"]/div[2]/div[2]/div[1]
    Input Text    add-parcel-tracking-code    ${TRACKNUMBER}
    Click Element    //*[@id="pageParcelTracking"]/div[2]/div[3]/div[1]/button/span
    Wait Until Element Is Visible    //*[@id="JJFI234567890_3b13e6ca-6ad8-49a8-b5be-8740808129b4"]
    Click Element    //*[@id="JJFI234567890_3b13e6ca-6ad8-49a8-b5be-8740808129b4"]
    Wait Until Element Is Visible    ${OPTIONS}
    Click Element    ${OPTIONS}
    Wait Until Element Is Visible    //*[@id="options-menu"]/li[3]
    Click Element    //*[@id="options-menu"]/li[3]
    Wait Until Element Is Visible    //*[@id="delete-button"]
    Click Element    //*[@id="delete-button"]
    Wait Until Element Is Not Visible    //*[@id="JJFI234567890_3b13e6ca-6ad8-49a8-b5be-8740808129b4"]

Add And Delete Invoice
    Click Element   ${INVOICE}
    Wait Until Element Is Visible    //*[@id="addInvoice_modal"]/div
    Input Text    add_invoice_account_number    FI3318203000040212
    Input Text    add_invoice_recipient     TestInvoice
    Input Text    add_invoice_reference_number      10276964452
    Input Text    add_invoice_amount        65
    Input Text    add_invoice_due_date          12.12.2025
    Wait Until Element Is Visible    //*[@id="addInvoice_modal"]/div/div/div[3]/form/div[6]/div
    Click Element    //*[@id="addInvoice_modal"]/div/div/div[3]/form/div[6]/div
    Wait Until Element Is Visible    //*[@id="messageOptionsMenuButton"]
    Click Element    //*[@id="messageOptionsMenuButton"]
    Set Selenium Implicit Wait    5 seconds
    Wait Until Element Is Visible    //*[@id="contentColumn"]/div[1]/div[1]/div/div[2]/div/ul/li[2]
    Click Element    //*[@id="contentColumn"]/div[1]/div[1]/div/div[2]/div/ul/li[2]
    Wait Until Element Is Visible    //*[@id="contentColumn"]/div/div/span[2]/button[2]
    Click Element    //*[@id="contentColumn"]/div/div/span[2]/button[2]

Nearest Posti
    Click Element    //*[@id="label-mainMenuSettings"]
    Wait Until Element Is Visible    //*[@id="lowerMenuSettingsMyPickUpPoint"]
    Click Element    //*[@id="lowerMenuSettingsMyPickUpPoint"]
    Wait Until Element Is Visible    //*[@id="pageMyPickupPoint"]/div[1]/div/div[2]/div[3]/button
    Click Element    //*[@id="pageMyPickupPoint"]/div[1]/div/div[2]/div[3]/button
    Wait Until Element Is Visible    //*[@id="pageMyPickupPoint"]/div[1]/div/div[1]/div/input
    Input Text    //*[@id="pageMyPickupPoint"]/div[1]/div/div[1]/div/input      02210
    Wait Until Element Is Visible    //*[@id="pageMyPickupPoint"]/div[1]/div/div[2]/div[1]
    Click Element    //*[@id="pageMyPickupPoint"]/div[1]/div/div[2]/div[1]