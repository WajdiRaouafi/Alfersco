*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Afficher les détails du dossier (action directe sur hover)
${det_Dossier_1}              xpath=//h3[@class='filename']//a[text()='
${det_Dossier_2}              ']/ancestor::tr//a[@title='Afficher les détails']

# Page Détails du dossier — panneau actions latéral
${lnk_Gerer_Autorisations}    xpath=//a[@title='Gérer les autorisations']

# Page Gestion des autorisations
${btn_Ajouter_Utilisateur}    xpath=//button[@id='template_x002e_manage-permissions_x002e_manage-permissions_x0023_default-addUserGroupButton-button']
${input_Recherche_Autori}     xpath=//input[@id='template_x002e_manage-permissions_x002e_manage-permissions_x0023_default-authorityFinder-search-text']
${btn_Rechercher_Autori}      xpath=//button[@id='template_x002e_manage-permissions_x002e_manage-permissions_x0023_default-authorityFinder-authority-search-button-button']
${btn_Ajouter_Resultat}       xpath=//td[contains(@class,'yui-dt-col-actions')]//button[normalize-space()='Ajouter']
${btn_Enregistrer_Autori}     xpath=//button[@id='template_x002e_manage-permissions_x002e_manage-permissions_x0023_default-okButton-button']

*** Keywords ***
Afficher les détails du dossier
    [Arguments]    ${vNomDossier}
    Wait Until Element Is Visible    xpath=//h3[@class='filename']//a[text()='${vNomDossier}']    10s
    Mouse Over                       xpath=//h3[@class='filename']//a[text()='${vNomDossier}']
    Wait Until Element Is Visible    ${det_Dossier_1}${vNomDossier}${det_Dossier_2}              10s
    Click Element                    ${det_Dossier_1}${vNomDossier}${det_Dossier_2}

Gérer les autorisations du dossier
    Wait Until Element Is Visible    ${lnk_Gerer_Autorisations}    10s
    Click Element                    ${lnk_Gerer_Autorisations}

Ajouter un groupe aux autorisations
    [Arguments]    ${vNomGroupe}
    Wait Until Element Is Visible    ${btn_Ajouter_Utilisateur}      10s
    Click Element                    ${btn_Ajouter_Utilisateur}
    Wait Until Element Is Visible    ${input_Recherche_Autori}       10s
    Input Text                       ${input_Recherche_Autori}       ${vNomGroupe}
    Click Element                    ${btn_Rechercher_Autori}
    Wait Until Element Is Visible    ${btn_Ajouter_Resultat}         10s
    Click Element                    ${btn_Ajouter_Resultat}
    Sleep    1s

Enregistrer les autorisations
    Wait Until Element Is Visible    ${btn_Enregistrer_Autori}    10s
    Wait Until Element Is Enabled    ${btn_Enregistrer_Autori}    10s
    Click Element                    ${btn_Enregistrer_Autori}
    Wait Until Element Is Visible    ${lnk_Gerer_Autorisations}   15s
