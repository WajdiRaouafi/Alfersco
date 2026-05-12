*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Création fichier texte (page dédiée create-content)
${btn_Creer_K25}                 xpath=//button[contains(@id,'createContent-button-button')]
${mnu_Texte_K25}                 xpath=//span[contains(@class,'text-file') and contains(text(),'Plein texte')]
${input_Nom_Fichier}             xpath=//input[@name='prop_cm_name']
${btn_Enregistrer_Fichier}       xpath=//button[contains(@id,'form-submit-button')]

# Favori sur la page Détails du document
# Non favori : <a class="favourite-document" ...>Favori</a>  (texte visible)
# Favori     : <a class="favourite-action-favourite" ...></a> (texte vide)
${fav_Doc_Lien}                  xpath=//a[contains(@class,'favourite-document') and text()='Favori']
${fav_Doc_Active}                xpath=//a[contains(@class,'favourite-action-favourite')]

# Suppression fichier
${del_ShowMore_F1}               xpath=//h3[@class='filename']//a[text()='
${del_ShowMore_F2}               ']/ancestor::tr//a[@class='show-more']

${del_Fichier_1}                 xpath=//h3[@class='filename']//a[text()='
${del_Fichier_2}                 ']/ancestor::tr//a[@title='Supprimer le document']

${btn_Confirm_Suppr_F}           xpath=//div[contains(@class,'yui-dialog')]//button[text()='Supprimer']

*** Keywords ***
Créer un fichier texte dans un dossier
    [Arguments]    ${vNomFichier}
    Click Element                    ${btn_Creer_K25}
    Wait Until Element Is Visible    ${mnu_Texte_K25}            10s
    Click Element                    ${mnu_Texte_K25}
    Wait Until Element Is Visible    ${input_Nom_Fichier}        10s
    Input Text                       ${input_Nom_Fichier}        ${vNomFichier}
    Click Element                    ${btn_Enregistrer_Fichier}
    # Alfresco redirige vers la page Détails du document
    Wait Until Element Is Visible    ${fav_Doc_Lien}             10s

Définir fichier comme favori
    Wait Until Element Is Visible    ${fav_Doc_Lien}             10s
    Click Element                    ${fav_Doc_Lien}

Vérifier fichier est favori
    # Après clic : le texte "Favori" disparaît et la classe favourite-action-favourite est ajoutée
    Wait Until Element Is Not Visible    ${fav_Doc_Lien}         10s
    Wait Until Element Is Visible        ${fav_Doc_Active}       10s
    Element Should Be Visible            ${fav_Doc_Active}

Supprimer un fichier dans un dossier
    [Arguments]    ${vNomFichier}
    Wait Until Element Is Visible    xpath=//h3[@class='filename']//a[text()='${vNomFichier}']    10s
    Mouse Over                       xpath=//h3[@class='filename']//a[text()='${vNomFichier}']
    Wait Until Element Is Visible    ${del_ShowMore_F1}${vNomFichier}${del_ShowMore_F2}    10s
    Click Element                    ${del_ShowMore_F1}${vNomFichier}${del_ShowMore_F2}
    Sleep    0.5s
    Wait Until Element Is Visible    ${del_Fichier_1}${vNomFichier}${del_Fichier_2}       10s
    Click Element                    ${del_Fichier_1}${vNomFichier}${del_Fichier_2}
    Wait Until Element Is Visible    ${btn_Confirm_Suppr_F}      10s
    Click Element                    ${btn_Confirm_Suppr_F}
    Wait Until Element Is Not Visible
    ...    xpath=//h3[@class='filename']//a[text()='${vNomFichier}']    10s
