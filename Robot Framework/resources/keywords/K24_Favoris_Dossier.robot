*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Navigation
${lnk_Mes_Fichiers}              xpath=//a[@title='Mes fichiers']
${btn_Creer_K24}                 xpath=//button[contains(@id,'createContent-button-button')]

# Création dossier (dialogue)
${mnu_Dossier_K24}               xpath=//span[contains(@class,'folder-file') and text()='Dossier']
${input_Nom_Dossier}             xpath=//input[contains(@id,'createFolder_prop_cm_name')]
${btn_Enregistrer_Dossier}       xpath=//button[contains(@id,'createFolder-form-submit-button')]

# Suppression dossier
${del_ShowMore_D1}               xpath=//h3[@class='filename']//a[text()='
${del_ShowMore_D2}               ']/ancestor::tr//a[@class='show-more']

${del_Dossier_1}                 xpath=//h3[@class='filename']//a[text()='
${del_Dossier_2}                 ']/ancestor::tr//a[@title='Supprimer le Dossier']

${btn_Confirm_Suppr_D}           xpath=//div[contains(@class,'yui-dialog')]//button[text()='Supprimer']

*** Keywords ***
Naviguer vers Mes Fichiers
    Wait Until Element Is Visible    ${lnk_Mes_Fichiers}    10s
    Click Element                    ${lnk_Mes_Fichiers}
    Wait Until Element Is Visible    ${btn_Creer_K24}        10s

Entrer dans un dossier
    [Arguments]    ${vNomDossier}
    Wait Until Element Is Visible    xpath=//h3[@class='filename']//a[text()='${vNomDossier}']    10s
    Click Element                    xpath=//h3[@class='filename']//a[text()='${vNomDossier}']
    Wait Until Element Is Not Visible    xpath=//h3[@class='filename']//a[text()='${vNomDossier}']    10s
    Wait Until Element Is Visible        ${btn_Creer_K24}    10s

Créer un dossier dans Mes Fichiers
    [Arguments]    ${vNomDossier}
    Click Element                    ${btn_Creer_K24}
    Wait Until Element Is Visible    ${mnu_Dossier_K24}      10s
    Click Element                    ${mnu_Dossier_K24}
    Wait Until Element Is Visible    ${input_Nom_Dossier}    10s
    Input Text                       ${input_Nom_Dossier}    ${vNomDossier}
    Click Element                    ${btn_Enregistrer_Dossier}
    Wait Until Element Is Visible
    ...    xpath=//h3[@class='filename']//a[text()='${vNomDossier}']    10s

Supprimer un dossier dans Mes Fichiers
    [Arguments]    ${vNomDossier}
    Wait Until Element Is Visible    xpath=//h3[@class='filename']//a[text()='${vNomDossier}']    10s
    Mouse Over                       xpath=//h3[@class='filename']//a[text()='${vNomDossier}']
    Wait Until Element Is Visible    ${del_ShowMore_D1}${vNomDossier}${del_ShowMore_D2}    10s
    Click Element                    ${del_ShowMore_D1}${vNomDossier}${del_ShowMore_D2}
    Sleep    0.5s
    Wait Until Element Is Visible    ${del_Dossier_1}${vNomDossier}${del_Dossier_2}       10s
    Click Element                    ${del_Dossier_1}${vNomDossier}${del_Dossier_2}
    Wait Until Element Is Visible    ${btn_Confirm_Suppr_D}  10s
    Click Element                    ${btn_Confirm_Suppr_D}
    Wait Until Element Is Not Visible
    ...    xpath=//h3[@class='filename']//a[text()='${vNomDossier}']    10s
