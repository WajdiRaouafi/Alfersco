*** Settings ***
Library      SeleniumLibrary
Variables    ../locators/locators.py

*** Variables ***
${TIMEOUT}    10s

*** Keywords ***
Login
    # vURL      : adresse URL de la page web
    # vBrowser  : identifiant du navigateur cible
    # vUsername : login
    # vPassword : mot de passe
    [Arguments]    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}
    Set Selenium Timeout    ${TIMEOUT}
    Open Browser    ${vURL}    ${vBrowser}    options=add_argument("--lang=fr")
    Maximize Browser Window
    Input Text    ${txt_UserName}    ${vUsername}
    Input Text    ${txt_Password}    ${vPassword}
    Click Button    ${btn_Login}
    Wait Until Element Is Visible    ${lblTitle}    10s
    Element Should Contain           ${lblTitle}    Tableau de bord de
