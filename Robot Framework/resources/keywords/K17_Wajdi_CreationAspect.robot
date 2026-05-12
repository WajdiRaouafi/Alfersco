*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Navigation
${lnk_Outils_Admin_Aspect}          xpath=//div[@id='HEADER_ADMIN_CONSOLE']/span/a
${lnk_Gestionnaire_Modeles_Aspect}  xpath=//a[@title='Gestionnaire de modèles']

# Sélection modèle
${lbl_Modele_Aspect_1}              xpath=//span[contains(@class,'value') and contains(text(),'
${lbl_Modele_Aspect_2}              ')]

# Formulaire création aspect
${btn_Creer_Aspect}                  xpath=//span[text()='Créer un aspect']
${txt_Nom_Aspect}                    xpath=//input[@name='name']
${menu_Aspect_Parent}                xpath=//input[@value='▼ ']
${popup_Aspect_Parent}               xpath=//div[contains(@class,'dijitMenuPopup') and not(contains(@style,'display:none')) and not(contains(@style,'display: none'))]
${txt_Etiquette_Aspect}              xpath=//input[@name='title']
${txt_Description_Aspect}            xpath=//textarea[@name='description' and @autocomplete='off']
${btn_Valider_Creation_Aspect}       xpath=//span[normalize-space()='Créer' and not(contains(.,'aspect'))]

*** Keywords ***
Créer un aspect dans un modèle
    [Documentation]    Crée un aspect dans un modèle Alfresco existant.
    ...                ${vModele}       : nom du modèle cible
    ...                ${vNomAspect}    : nom de l'aspect
    ...                ${vAspectParent} : aspect parent dans le menu déroulant (défaut : Aucun)
    ...                ${vEtiquette}    : étiquette d'affichage (optionnelle)
    ...                ${vDescription}  : description (optionnelle)
    [Arguments]    ${vModele}    ${vNomAspect}    ${vAspectParent}=Aucun    ${vEtiquette}=${EMPTY}    ${vDescription}=${EMPTY}

    # Navigation vers Gestionnaire de modèles
    Wait Until Element Is Visible    ${lnk_Outils_Admin_Aspect}           10s
    Click Element                    ${lnk_Outils_Admin_Aspect}
    Wait Until Element Is Visible    ${lnk_Gestionnaire_Modeles_Aspect}   10s
    Click Element                    ${lnk_Gestionnaire_Modeles_Aspect}

    # Sélectionner le modèle
    Wait Until Element Is Visible    ${lbl_Modele_Aspect_1}${vModele}${lbl_Modele_Aspect_2}    10s
    Scroll Element Into View         ${lbl_Modele_Aspect_1}${vModele}${lbl_Modele_Aspect_2}
    Click Element                    ${lbl_Modele_Aspect_1}${vModele}${lbl_Modele_Aspect_2}

    # Ouvrir le formulaire création aspect
    Wait Until Element Is Visible    ${btn_Creer_Aspect}                   10s
    Click Element                    ${btn_Creer_Aspect}

    # Remplir le nom (obligatoire)
    Wait Until Element Is Visible    ${txt_Nom_Aspect}                     10s
    Input Text    ${txt_Nom_Aspect}    ${vNomAspect}

    # Sélectionner l'aspect parent (même approche que K15 pour les dropdowns Dojo)
    Click Element                    ${menu_Aspect_Parent}
    Wait Until Element Is Visible    ${popup_Aspect_Parent}//*[normalize-space(.)='${vAspectParent}']    10s
    Click Element                    ${popup_Aspect_Parent}//*[normalize-space(.)='${vAspectParent}']

    IF    '${vEtiquette}' != ''
        Input Text    ${txt_Etiquette_Aspect}    ${vEtiquette}
    END

    IF    '${vDescription}' != ''
        Input Text    ${txt_Description_Aspect}    ${vDescription}
    END

    # Valider la création
    Wait Until Element Is Visible    ${btn_Valider_Creation_Aspect}        10s
    Click Element                    ${btn_Valider_Creation_Aspect}

    # Vérification : l'aspect apparaît dans la liste du modèle
    Wait Until Element Is Visible    xpath=//span[contains(@class,'value') and contains(text(),'${vNomAspect}')]    10s
    Element Should Be Visible        xpath=//span[contains(@class,'value') and contains(text(),'${vNomAspect}')]
