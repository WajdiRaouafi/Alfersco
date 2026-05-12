*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Navigation
${lnk_Sites_Menu_K20}       xpath=//span[@id='HEADER_SITES_MENU_text']
${lnk_Creation_Site}        xpath=//td[@id='HEADER_SITES_MENU_CREATE_SITE_text']

# Formulaire création site
${input_Nom_Site}            xpath=//input[@class='dijitReset dijitInputInner' and @name='title']
${input_Nom_URL_Site}        xpath=//input[@class='dijitReset dijitInputInner' and @name='shortName']
${input_Description_Site}    xpath=//textarea[@class='dijitTextBox dijitTextArea' and @name='description']
${radio_Visibilite_1}        xpath=//input[@name='visibility' and @value='
${radio_Visibilite_2}        ']
${btn_Creer_Site}            xpath=//span[@id='CREATE_SITE_DIALOG_OK']

# Vérification création site
${lbl_Titre_Site_1}          xpath=//a[contains(@class,'alfresco-navigation-_HtmlAnchorMixin') and @title='
${lbl_Titre_Site_2}          ']

# Personnalisation : ajout du module Wiki
${btn_Config_Site}           id=HEADER_SITE_CONFIGURATION_DROPDOWN
${lnk_Perso_Site}            xpath=//a[@title='Personnaliser le site']
${drag_Wiki_Module}          id=template_x002e_customise-pages_x002e_customise-site_x0023_default-page-wiki-page
${drop_Current_Pages}        id=template_x002e_customise-pages_x002e_customise-site_x0023_default-currentPages-ul
${btn_OK_Perso}              id=template_x002e_customise-pages_x002e_customise-site_x0023_default-save-button-button

*** Keywords ***
Créer un site
    [Documentation]    Crée un nouveau site Alfresco depuis le menu Sites.
    ...                ${vNomSite}     : nom affiché du site
    ...                ${vNomURL}      : identifiant URL (sans espaces ni accents)
    ...                ${vDescription} : description du site
    ...                ${vVisibilite}  : PUBLIC | MODERATED | PRIVATE (défaut : PUBLIC)
    [Arguments]    ${vNomSite}    ${vNomURL}    ${vDescription}    ${vVisibilite}=PUBLIC

    # Ouvrir le menu Sites
    Wait Until Element Is Visible    ${lnk_Sites_Menu_K20}    10s
    Click Element                    ${lnk_Sites_Menu_K20}

    # Cliquer sur Créer un site
    Wait Until Element Is Visible    ${lnk_Creation_Site}     10s
    Click Element                    ${lnk_Creation_Site}

    # Remplir le formulaire
    Wait Until Element Is Visible    ${input_Nom_Site}        10s
    Input Text    ${input_Nom_Site}          ${vNomSite}
    Input Text    ${input_Nom_URL_Site}      ${vNomURL}
    Input Text    ${input_Description_Site}  ${vDescription}

    # Sélectionner la visibilité
    Click Element    ${radio_Visibilite_1}${vVisibilite}${radio_Visibilite_2}

    # Valider
    Wait Until Element Is Enabled    ${btn_Creer_Site}        20s
    Click Element                    ${btn_Creer_Site}
    Sleep    3s

    # Vérification : titre du site visible sur la page
    Wait Until Element Is Visible    ${lbl_Titre_Site_1}${vNomSite}${lbl_Titre_Site_2}    30s
    Element Should Be Visible        ${lbl_Titre_Site_1}${vNomSite}${lbl_Titre_Site_2}

    # ── PERSONNALISATION : activer le module Wiki ─────────────────────────────
    # Ouvrir le menu Options de configuration du site
    Wait Until Element Is Visible    ${btn_Config_Site}    10s
    Click Element                    ${btn_Config_Site}

    # Cliquer sur Personnaliser le site
    Wait Until Element Is Visible    ${lnk_Perso_Site}    10s
    Click Element                    ${lnk_Perso_Site}

    # Glisser le module Wiki depuis "pages disponibles" vers "pages actives"
    Wait Until Element Is Visible    ${drag_Wiki_Module}    10s
    Drag And Drop                    ${drag_Wiki_Module}    ${drop_Current_Pages}

    # Valider avec OK
    Wait Until Element Is Visible    ${btn_OK_Perso}    10s
    Click Element                    ${btn_OK_Perso}

    # Vérification : le lien Wiki est maintenant visible dans la barre du site
    Wait Until Element Is Visible    xpath=//a[@title='Wiki']    10s