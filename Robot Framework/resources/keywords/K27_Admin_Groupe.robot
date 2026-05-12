*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Navigation vers Admin Tools > Groupes
${lnk_Outils_Admin_K27}         xpath=//a[@title='Admin Tools'] | //a[contains(normalize-space(.),'Outils admin')]
${lnk_Groupes_K27}              xpath=//a[contains(normalize-space(.),'Groups') or contains(normalize-space(.),'Groupes')]

# Création groupe
${btn_Parcourir_K27}             xpath=//button[contains(normalize-space(.),'Parcourir')] | //button[contains(normalize-space(.),'Browse')]
${btn_Nouveau_Groupe_K27}        xpath=//span[@title='Nouveau groupe' or @title='New Group']
${input_ShortName_Groupe}        xpath=//*[@id='page_x002e_ctool_x002e_admin-console_x0023_default-create-shortname']
${input_NomAffichage_Groupe}     xpath=//*[@id='page_x002e_ctool_x002e_admin-console_x0023_default-create-displayname']
${btn_Creer_Groupe}              xpath=//button[contains(normalize-space(.),'Créer un groupe')] | //button[contains(normalize-space(.),'Create Group')]

*** Keywords ***
Naviguer vers Gestion des Groupes
    Wait Until Element Is Visible    ${lnk_Outils_Admin_K27}    10s
    Click Element                    ${lnk_Outils_Admin_K27}
    Wait Until Element Is Visible    ${lnk_Groupes_K27}         10s
    Click Element                    ${lnk_Groupes_K27}
    Wait Until Page Contains         Groups                      10s

Créer un groupe
    [Arguments]    ${vNomCourt}    ${vNomAffichage}
    Wait Until Element Is Visible    ${btn_Parcourir_K27}          10s
    Click Element                    ${btn_Parcourir_K27}
    Sleep    2s
    Wait Until Element Is Visible    ${btn_Nouveau_Groupe_K27}     10s
    Click Element                    ${btn_Nouveau_Groupe_K27}
    Wait Until Element Is Visible    ${input_ShortName_Groupe}     10s
    Input Text                       ${input_ShortName_Groupe}     ${vNomCourt}
    Input Text                       ${input_NomAffichage_Groupe}  ${vNomAffichage}
    Click Element                    ${btn_Creer_Groupe}
    Wait Until Page Contains         ${vNomCourt}                  10s
