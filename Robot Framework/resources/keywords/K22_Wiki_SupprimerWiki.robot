*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Navigation
${lnk_Sites_Menu_K22}        xpath=//span[@id='HEADER_SITES_MENU_text']
${lnk_Mes_Sites_K22}         xpath=//a[@title='Mes sites']
${lnk_Mon_Site_K22_1}        xpath=//a[contains(text(),'
${lnk_Mon_Site_K22_2}        ')]
${lnk_Wiki_K22}              xpath=//a[@title='Wiki']
${lnk_Liste_Pages_K22}       xpath=//span[@class='forwardLink']/child::a

# Suppression directement depuis la liste des pages
${lnk_Delete_Wiki_1}         xpath=//a[contains(@class,'delete-link') and @title='
${lnk_Delete_Wiki_2}         ']
${btn_Confirm_Delete_Wiki}   id=yui-gen1-button

*** Keywords ***
Supprimer une page Wiki
    [Documentation]    Supprime une page wiki depuis la liste des pages du site.
    ...                vNomSite : nom affiché du site
    ...                vNomWiki : titre exact de la page wiki à supprimer
    [Arguments]    ${vNomSite}    ${vNomWiki}

    # Naviguer vers le site
    Wait Until Element Is Visible    ${lnk_Sites_Menu_K22}                                    10s
    Click Element                    ${lnk_Sites_Menu_K22}
    Wait Until Element Is Visible    ${lnk_Mes_Sites_K22}                                     10s
    Click Element                    ${lnk_Mes_Sites_K22}
    Wait Until Element Is Visible    ${lnk_Mon_Site_K22_1}${vNomSite}${lnk_Mon_Site_K22_2}   10s
    Click Element                    ${lnk_Mon_Site_K22_1}${vNomSite}${lnk_Mon_Site_K22_2}

    # Ouvrir le wiki puis la liste des pages
    Wait Until Element Is Visible    ${lnk_Wiki_K22}                                          10s
    Click Element                    ${lnk_Wiki_K22}
    Wait Until Element Is Visible    ${lnk_Liste_Pages_K22}                                   10s
    Click Element                    ${lnk_Liste_Pages_K22}

    # Cliquer sur le lien "Supprimer" de la page wiki ciblée (dans la liste)
    Wait Until Element Is Visible    ${lnk_Delete_Wiki_1}${vNomWiki}${lnk_Delete_Wiki_2}      10s
    Click Element                    ${lnk_Delete_Wiki_1}${vNomWiki}${lnk_Delete_Wiki_2}

    # Confirmer la suppression
    Wait Until Element Is Visible    ${btn_Confirm_Delete_Wiki}                               10s
    Click Button                     ${btn_Confirm_Delete_Wiki}
    Sleep    1s

    # Retour à la liste des pages pour vérification
    Wait Until Element Is Visible    ${lnk_Wiki_K22}                                          10s
    Click Element                    ${lnk_Wiki_K22}
    Wait Until Element Is Visible    ${lnk_Liste_Pages_K22}                                   10s
    Click Element                    ${lnk_Liste_Pages_K22}

    # Vérification : la page supprimée n'est plus dans la liste
    Page Should Not Contain    ${vNomWiki}