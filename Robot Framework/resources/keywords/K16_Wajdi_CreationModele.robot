*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Navigation
${lnk_Outils_Admin_Modele}          xpath=//span[@id='HEADER_ADMIN_CONSOLE_text']
${lnk_Gestionnaire_Modeles_Modele}  xpath=//a[normalize-space(text())='Gestionnaire de modèles']

# Formulaire création modèle
${btn_Creer_Modele}                  xpath=//span[contains(@class,'alfresco-buttons-AlfButton') and contains(@class,'createButton')]
${input_Espace_Nom}                  xpath=//div[contains(@class,'dijitInputField')]//input[@name='namespace']
${input_Prefixe}                     xpath=//div[contains(@class,'dijitInputField')]//input[@name='prefix']
${input_Nom_Modele}                  xpath=//div[contains(@class,'dijitInputField')]//input[@name='name']
${input_Createur}                    xpath=//div[contains(@class,'dijitInputField')]//input[@name='author']
${input_Description_Modele}          xpath=//textarea[@class='dijitTextBox dijitTextArea' and @name='description']
${btn_Valider_Creation_Modele}       xpath=//span[@role='button']//span[normalize-space()='Créer']

*** Keywords ***
Créer un modèle
    [Documentation]    Crée un nouveau modèle dans le Gestionnaire de modèles Alfresco.
    ...                ${vEspaceNom}   : espace de noms (namespace)
    ...                ${vPrefixe}     : préfixe du modèle
    ...                ${vNom}         : nom du modèle
    ...                ${vCreateur}    : nom du créateur
    ...                ${vDescription} : description (optionnelle)
    [Arguments]    ${vEspaceNom}    ${vPrefixe}    ${vNom}    ${vCreateur}    ${vDescription}=${EMPTY}

    # Navigation vers Gestionnaire de modèles
    Wait Until Element Is Visible    ${lnk_Outils_Admin_Modele}            10s
    Click Element                    ${lnk_Outils_Admin_Modele}
    Wait Until Element Is Visible    ${lnk_Gestionnaire_Modeles_Modele}    10s
    Click Element                    ${lnk_Gestionnaire_Modeles_Modele}

    # Ouvrir le formulaire
    Wait Until Element Is Visible    ${btn_Creer_Modele}                   10s
    Click Element                    ${btn_Creer_Modele}

    # Remplir le formulaire
    Wait Until Element Is Visible    ${input_Espace_Nom}                   10s
    Input Text    ${input_Espace_Nom}       ${vEspaceNom}
    Input Text    ${input_Prefixe}          ${vPrefixe}
    Input Text    ${input_Nom_Modele}       ${vNom}
    Input Text    ${input_Createur}         ${vCreateur}

    IF    '${vDescription}' != ''
        Input Text    ${input_Description_Modele}    ${vDescription}
    END

    # Valider la création
    Wait Until Element Is Visible    ${btn_Valider_Creation_Modele}        10s
    Click Element                    ${btn_Valider_Creation_Modele}

    # Vérification : le modèle apparaît dans la liste
    Wait Until Element Is Visible    xpath=//span[contains(@class,'value') and contains(text(),'${vNom}')]    10s
    Element Should Be Visible        xpath=//span[contains(@class,'value') and contains(text(),'${vNom}')]
