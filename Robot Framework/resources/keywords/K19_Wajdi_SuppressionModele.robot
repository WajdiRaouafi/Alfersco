*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Navigation
${lnk_Outils_Admin_K19}          xpath=//a[@title='Outils admin' and normalize-space()='Outils admin']
${lnk_Gestionnaire_Modeles_K19}  xpath=//a[@title='Gestionnaire de modèles' and @href='custom-model-manager']

# Bouton Actions du modèle
${btn_Modele_Action_1}            xpath=//td[contains(@class,'nameColumn')]//span[contains(text(),'
${btn_Modele_Action_2}            ')]/ancestor::tr/td[contains(@class,'actionsColumn')]//span[text()='Actions']

# Option Supprimer dans le menu Actions
${btn_Supprimer_Modele_Option}    xpath=//div[contains(@class,'dijitPopup') and contains(@class,'Popup')]//tr[@title='Supprimer']//td[contains(@class,'dijitMenuItemLabel')]

# Dialogue de confirmation de suppression du modèle
${btn_Confirmer_Suppression_Modele}    xpath=//div[@role='dialog' and .//span[text()='Supprimer le modèle']]//span[@role='button' and .//span[text()='Supprimer']]

# Vérification
${lbl_Modele_K19_1}              xpath=//span[contains(@class,'value') and contains(text(),'
${lbl_Modele_K19_2}              ')]

*** Keywords ***
Supprimer un modèle
    [Documentation]    Supprime un modèle depuis le Gestionnaire de modèles Alfresco.
    ...                ${vNomModele} : nom du modèle à supprimer
    [Arguments]    ${vNomModele}

    # Navigation vers Gestionnaire de modèles
    Wait Until Element Is Visible    ${lnk_Outils_Admin_K19}           10s
    Click Element                    ${lnk_Outils_Admin_K19}
    Wait Until Element Is Visible    ${lnk_Gestionnaire_Modeles_K19}   10s
    Click Element                    ${lnk_Gestionnaire_Modeles_K19}

    # Cliquer sur Actions du modèle
    Wait Until Element Is Visible    ${btn_Modele_Action_1}${vNomModele}${btn_Modele_Action_2}    10s
    Click Element                    ${btn_Modele_Action_1}${vNomModele}${btn_Modele_Action_2}

    # Cliquer Supprimer
    Wait Until Element Is Visible    ${btn_Supprimer_Modele_Option}    10s
    Click Element                    ${btn_Supprimer_Modele_Option}

    # Confirmer dans le dialogue
    Wait Until Element Is Visible    ${btn_Confirmer_Suppression_Modele}    10s
    Click Element                    ${btn_Confirmer_Suppression_Modele}

    # Vérification : le modèle n'est plus visible
    Wait Until Element Is Not Visible    ${lbl_Modele_K19_1}${vNomModele}${lbl_Modele_K19_2}    10s