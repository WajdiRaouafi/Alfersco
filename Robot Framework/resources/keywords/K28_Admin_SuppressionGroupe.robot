*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Navigation vers Admin Tools > Gestion des groupes
${lnk_Outils_Admin_K28}          xpath=//a[@title='Admin Tools'] | //a[contains(normalize-space(.),'Outils admin')]
${lnk_Gestion_Groupes_K28}       xpath=//a[@title='Gestion des groupes']

# Suppression groupe
${input_Recherche_Groupe_K28}     xpath=//div[@class='yui-u first']/div/input
${btn_Rechercher_Groupe_K28}      xpath=//div[@class='search-button']//button[text()='Rechercher']
${btn_Supprimer_Groupe_K28}       xpath=//a[@class='delete']
${btn_Confirmer_Suppr_Groupe}     xpath=//button[@id='page_x002e_ctool_x002e_admin-console_x0023_default-remove-button-button']

*** Keywords ***
Supprimer un groupe
    [Arguments]    ${vNomCourt}
    Wait Until Element Is Visible    ${lnk_Outils_Admin_K28}          10s
    Click Element                    ${lnk_Outils_Admin_K28}
    Wait Until Element Is Visible    ${lnk_Gestion_Groupes_K28}       10s
    Click Element                    ${lnk_Gestion_Groupes_K28}
    Wait Until Element Is Visible    ${input_Recherche_Groupe_K28}    10s
    Input Text                       ${input_Recherche_Groupe_K28}    ${vNomCourt}
    Click Button                     ${btn_Rechercher_Groupe_K28}
    Wait Until Element Is Visible    ${btn_Supprimer_Groupe_K28}      5s
    Click Element                    ${btn_Supprimer_Groupe_K28}
    Click Button                     ${btn_Confirmer_Suppr_Groupe}
