*** Settings ***
Library      SeleniumLibrary
Variables    ../locators/locators.py

*** Keywords ***
Logout
    Sleep    1s
    Click Element    ${link_HeaderUserMenu}
    Sleep    2s
    Click Element    ${link_HeaderDeconnexion}
    [Teardown]    Close Browser
