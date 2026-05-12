*** Settings ***
Library          SeleniumLibrary
Variables        ./resources/data/variables_wiki.py
Resource         ./resources/keywords/K46_Talel_Login.robot
Resource         ./resources/keywords/K47_Talel_Logout.robot
Resource         ./resources/keywords/K20_Wiki_CreerSite.robot
Resource         ./resources/keywords/K21_Wiki_CreerWiki.robot
Resource         ./resources/keywords/K22_Wiki_SupprimerWiki.robot
Resource         ./resources/keywords/K23_Wiki_SupprimerSite.robot

Suite Setup      Préconditions
Test Template    Créer et Vérifier page Wiki
Suite Teardown   Postconditions

*** Variables ***
# VM
${URL}        http://192.168.0.25
${BROWSER}    chrome
${USERNAME}   admin
${PASSWORD}   YI3ShPL4ohnz

# Putty
# ${URL}          http://localhost:8055
# ${BROWSER}      chrome
# ${USERNAME}     6355819
# ${PASSWORD}     6355819

*** Test Cases ***
Wiki page 1    ${WIKI_PAGE_1}[nom_wiki]    ${WIKI_PAGE_1}[version_attendue]
Wiki page 2    ${WIKI_PAGE_2}[nom_wiki]    ${WIKI_PAGE_2}[version_attendue]

*** Keywords ***
Préconditions
    Login    ${URL}/share/page    ${BROWSER}    ${USERNAME}    ${PASSWORD}
    Créer un site
    ...    ${WIKI_SITE}[nom_site]
    ...    ${WIKI_SITE}[nom_url_site]
    ...    ${WIKI_SITE}[description_site]
    ...    ${WIKI_SITE}[visibilite]

Créer et Vérifier page Wiki
    [Arguments]    ${nom_wiki}    ${version_attendue}
    Créer une page Wiki         ${WIKI_SITE}[nom_site]    ${nom_wiki}
    Vérifier version page Wiki  ${WIKI_SITE}[nom_site]    ${nom_wiki}    ${version_attendue}

Postconditions
    FOR    ${wiki}    IN    @{WIKI_PAGES}
        Supprimer une page Wiki    ${WIKI_SITE}[nom_site]    ${wiki}[nom_wiki]
    END
    Supprimer un site    ${URL}    ${WIKI_SITE}[nom_url_site]    ${WIKI_SITE}[nom_site]
    Logout