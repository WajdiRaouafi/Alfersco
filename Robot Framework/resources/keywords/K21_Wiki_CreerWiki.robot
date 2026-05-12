*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Navigation commune
${lnk_Sites_Menu_K21}       id=HEADER_SITES_MENU_text
${lnk_Mes_Sites_K21}        id=HEADER_SITES_MENU_MY_SITES
${lnk_Mon_Site_K21_1}       xpath=//a[contains(text(),'
${lnk_Mon_Site_K21_2}       ')]
${lnk_Wiki_K21}             xpath=//a[@title='Wiki']

# Création wiki
${btn_Nouvelle_Page_Wiki}    xpath=//div[@class='new-page']//button
${txt_Titre_Wiki}            xpath=//div/input[@name='pageTitle']
${btn_Sauvegarder_Wiki}      xpath=//div[@class='yui-u']/span/span/button

# Vérification version
${lnk_Liste_Pages_Wiki}      xpath=//span[@class='forwardLink']/child::a
${lnk_Details_Wiki_1}        xpath=//a[contains(@href,'title=
${lnk_Details_Wiki_2}        ') and contains(@href,'action=details')]
${btn_Version_Wiki}          xpath=//div[contains(@class,'version-quick-change')]//button

*** Keywords ***
Créer une page Wiki
    [Documentation]    Crée une nouvelle page wiki dans un site existant.
    ...                ${vNomSite} : nom affiché du site
    ...                ${vNomWiki} : titre de la page wiki
    [Arguments]    ${vNomSite}    ${vNomWiki}

    # Naviguer vers le site
    Wait Until Element Is Visible    ${lnk_Sites_Menu_K21}                              10s
    Click Element                    ${lnk_Sites_Menu_K21}
    Wait Until Element Is Visible    ${lnk_Mes_Sites_K21}                               10s
    Click Element                    ${lnk_Mes_Sites_K21}
    Wait Until Element Is Visible    ${lnk_Mon_Site_K21_1}${vNomSite}${lnk_Mon_Site_K21_2}    10s
    Click Element                    ${lnk_Mon_Site_K21_1}${vNomSite}${lnk_Mon_Site_K21_2}

    # Ouvrir le wiki
    Wait Until Element Is Visible    ${lnk_Wiki_K21}                                    10s
    Click Element                    ${lnk_Wiki_K21}

    # Créer la nouvelle page
    Wait Until Element Is Visible    ${btn_Nouvelle_Page_Wiki}                          10s
    Click Button                     ${btn_Nouvelle_Page_Wiki}
    Wait Until Element Is Visible    ${txt_Titre_Wiki}                                  10s
    Input Text                       ${txt_Titre_Wiki}    ${vNomWiki}
    Click Button                     ${btn_Sauvegarder_Wiki}

    # Vérification : la page créée est visible
    Wait Until Page Contains         ${vNomWiki}                                        10s
    Page Should Contain              ${vNomWiki}

Vérifier version page Wiki
    [Documentation]    Vérifie la version d'une page wiki depuis la liste des pages.
    ...                Version 1.0 = première création, 1.1 après 1ère modif, etc.
    ...                ${vNomSite}      : nom affiché du site
    ...                ${vNomWiki}      : titre de la page wiki
    ...                ${vVersionAtt}   : version attendue (défaut : 1.0)
    [Arguments]    ${vNomSite}    ${vNomWiki}    ${vVersionAtt}=1.0

    # Naviguer vers le wiki du site
    Wait Until Element Is Visible    ${lnk_Sites_Menu_K21}                              10s
    Click Element                    ${lnk_Sites_Menu_K21}
    Wait Until Element Is Visible    ${lnk_Mes_Sites_K21}                               10s
    Click Element                    ${lnk_Mes_Sites_K21}
    Wait Until Element Is Visible    ${lnk_Mon_Site_K21_1}${vNomSite}${lnk_Mon_Site_K21_2}    10s
    Click Element                    ${lnk_Mon_Site_K21_1}${vNomSite}${lnk_Mon_Site_K21_2}
    Wait Until Element Is Visible    ${lnk_Wiki_K21}                                    10s
    Click Element                    ${lnk_Wiki_K21}

    # Aller dans la liste des pages wiki
    Wait Until Element Is Visible    ${lnk_Liste_Pages_Wiki}                            10s
    Click Element                    ${lnk_Liste_Pages_Wiki}

    # Cliquer sur Détails de la page wiki ciblée
    Wait Until Element Is Visible    ${lnk_Details_Wiki_1}${vNomWiki}${lnk_Details_Wiki_2}    10s
    Click Element                    ${lnk_Details_Wiki_1}${vNomWiki}${lnk_Details_Wiki_2}

    # Vérifier que la version affichée contient la version attendue
    Wait Until Element Is Visible    ${btn_Version_Wiki}                                10s
    Element Should Contain           ${btn_Version_Wiki}                                ${vVersionAtt}