*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Navigation
${lnk_Outils_Admin_K18}          xpath=//a[@title='Outils admin' and normalize-space()='Outils admin']
${lnk_Gestionnaire_Modeles_K18}  xpath=//a[@title='Gestionnaire de modèles' and @href='custom-model-manager']

# Sélection modèle
${lbl_Modele_K18_1}              xpath=//span[contains(@class,'value') and contains(text(),'
${lbl_Modele_K18_2}              ')]

# Sélection aspect
${link_Aspect_1}                  xpath=//td[contains(@class,'nameColumn')]//span[contains(@class,'value') and contains(text(),'
${link_Aspect_2}                  ')]

# Bouton Actions de l'aspect
${btn_Aspect_Action_1}            xpath=//span[contains(@class,'value') and contains(text(),'
${btn_Aspect_Action_2}            ')]/ancestor::tr//span[text()='Actions']

# Menu supprimer
${btn_Supprimer_Aspect}           xpath=//div[contains(@class,'dijitPopup') and contains(@class,'Popup')]//tr[@title='Supprimer']//td[contains(@class,'dijitMenuItemLabel')]

# Confirmation
${btn_Confirmer_Suppression_Aspect}    xpath=//div[contains(@class,'dijitDialog')]//span[normalize-space()='Supprimer']

*** Keywords ***
Supprimer un aspect dans un modèle
    [Documentation]    Supprime un aspect dans un modèle Alfresco existant.
    ...                ${vNomModele}  : nom du modèle
    ...                ${vNomAspect}  : nom de l'aspect à supprimer
    [Arguments]    ${vNomModele}    ${vNomAspect}

    # Navigation vers Gestionnaire de modèles
    Wait Until Element Is Visible    ${lnk_Outils_Admin_K18}           10s
    Click Element                    ${lnk_Outils_Admin_K18}
    Wait Until Element Is Visible    ${lnk_Gestionnaire_Modeles_K18}   10s
    Click Element                    ${lnk_Gestionnaire_Modeles_K18}

    # Sélectionner le modèle
    Wait Until Element Is Visible    ${lbl_Modele_K18_1}${vNomModele}${lbl_Modele_K18_2}    10s
    Scroll Element Into View         ${lbl_Modele_K18_1}${vNomModele}${lbl_Modele_K18_2}
    Click Element                    ${lbl_Modele_K18_1}${vNomModele}${lbl_Modele_K18_2}

    # Survoler l'aspect pour faire apparaître le bouton Actions
    Wait Until Element Is Visible    ${link_Aspect_1}${vNomAspect}${link_Aspect_2}    10s
    Mouse Over                       ${link_Aspect_1}${vNomAspect}${link_Aspect_2}
    Sleep    1s

    # Cliquer Actions
    Wait Until Element Is Visible    ${btn_Aspect_Action_1}${vNomAspect}${btn_Aspect_Action_2}    10s
    Click Element                    ${btn_Aspect_Action_1}${vNomAspect}${btn_Aspect_Action_2}

    # Cliquer Supprimer
    Wait Until Element Is Visible    ${btn_Supprimer_Aspect}    10s
    Click Element                    ${btn_Supprimer_Aspect}

    # Confirmer la suppression
    Wait Until Element Is Visible    ${btn_Confirmer_Suppression_Aspect}    10s
    Click Element                    ${btn_Confirmer_Suppression_Aspect}

    # Vérification : l'aspect n'est plus visible
    Wait Until Element Is Not Visible    ${link_Aspect_1}${vNomAspect}${link_Aspect_2}    10s