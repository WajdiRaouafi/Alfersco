*** Settings ***
Library      SeleniumLibrary
Variables    ../locators/locators.py

*** Keywords ***
Menu Action
    # Clique sur une option du menu Actions d'un modèle.
    # vModele : nom du modèle
    # vOption : Activer | Désactiver | Modifier | Supprimer | Exporter
    [Arguments]    ${vModele}    ${vOption}
    Wait Until Element Is Visible    ${menu_Actions1}${vModele}${menu_Actions2}
    Click Element                    ${menu_Actions1}${vModele}${menu_Actions2}
    Wait Until Element Is Visible    ${menu_Action_Option1}${vOption}${menu_Action_Option2}
    Click Element                    ${menu_Action_Option1}${vOption}${menu_Action_Option2}
