*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Options de configuration du site
${div_Site_Config_Dropdown}      xpath=//div[@id='HEADER_SITE_CONFIGURATION_DROPDOWN']
${lnk_Delete_Site_Option}        xpath=//tr[@id='HEADER_DELETE_SITE']
${btn_Confirm_Delete_Site}       xpath=//span[@id='ALF_SITE_SERVICE_DIALOG_CONFIRMATION_label' and text()='OK']

# Vérification post-suppression (tableau de bord)
${lnk_Sites_Menu_K23}            xpath=//span[@id='HEADER_SITES_MENU_text']

*** Keywords ***
Supprimer un site
    [Documentation]    Supprime un site Alfresco depuis son tableau de bord.
    ...                ${vURL}          : URL de base (ex: http://localhost:8055)
    ...                ${vNomURLSite}   : identifiant URL du site (ex: mon-site-test)
    ...                ${vNomSite}      : nom affiché du site
    [Arguments]    ${vURL}    ${vNomURLSite}    ${vNomSite}

    # Naviguer directement vers le tableau de bord du site
    Go To    ${vURL}/share/page/site/${vNomURLSite}/dashboard

    # Ouvrir le menu Options du site et sélectionner Supprimer
    Wait Until Element Is Visible    ${div_Site_Config_Dropdown}    10s
    Click Element                    ${div_Site_Config_Dropdown}
    Wait Until Element Is Visible    ${lnk_Delete_Site_Option}      10s
    Click Element                    ${lnk_Delete_Site_Option}

    # Confirmer la suppression
    Wait Until Element Is Visible    ${btn_Confirm_Delete_Site}     10s
    Click Element                    ${btn_Confirm_Delete_Site}

    # Alfresco redirige vers le tableau de bord après suppression
    Sleep    3s
    Wait Until Element Is Visible    ${lnk_Sites_Menu_K23}          20s

    # Vérification : le site n'apparaît plus sur la page
    Page Should Not Contain    ${vNomSite}