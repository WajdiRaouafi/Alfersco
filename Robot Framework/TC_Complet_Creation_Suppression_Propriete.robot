*** Settings ***
Library          SeleniumLibrary
Variables        ./resources/data/variables.py
Resource         ./resources/keywords/K46_Talel_Login.robot
Resource         ./resources/keywords/K47_Talel_Logout.robot
Resource         ./resources/keywords/K16_Wajdi_CreationModele.robot
Resource         ./resources/keywords/K17_Wajdi_CreationAspect.robot
Resource         ./resources/keywords/K15_Wajdi_CreationPropriete.robot
Resource         ./resources/keywords/K33_Wajdi_SuppressionPropriete.robot
Resource         ./resources/keywords/K18_Wajdi_SuppressionAspect.robot
Resource         ./resources/keywords/K19_Wajdi_SuppressionModele.robot
Suite Setup      Préconditions
Suite Teardown   Postconditions
Test Template    Créer et Supprimer Propriété

*** Variables ***
# VM
${URL}        http://192.168.5.205
${BROWSER}    chrome
${USERNAME}   admin
${PASSWORD}   YI3ShPL4ohnz

# Putty
# ${URL}          http://localhost:8055
# ${BROWSER}      chrome
# ${USERNAME}     6355819
# ${PASSWORD}     6355819

*** Test Cases ***
Propriété 1    ${PROP_DATA_1}
Propriété 2    ${PROP_DATA_2}
Propriété 3    ${PROP_DATA_3}
Propriété 4    ${PROP_DATA_4}
Propriété 5    ${PROP_DATA_5}

*** Keywords ***
Préconditions
    Login    ${URL}/share/page    ${BROWSER}    ${USERNAME}    ${PASSWORD}
    Créer un modèle
    ...    ${MODEL_DATA}[espace_nom]
    ...    ${MODEL_DATA}[prefixe]
    ...    ${MODEL_DATA}[nom_modele]
    ...    ${MODEL_DATA}[createur]
    Créer un aspect dans un modèle
    ...    ${MODEL_DATA}[nom_modele]
    ...    ${ASPECT_DATA}[nom_aspect]
    ...    ${ASPECT_DATA}[aspect_parent]
    ...    ${ASPECT_DATA}[etiquette_aspect]
    Wait Until Element Is Visible    ${lnk_Outils_Admin}    10s
    Click Element                    ${lnk_Outils_Admin}
    Wait Until Element Is Visible    ${lnk_Gestionnaire_Modeles}    10s
    Click Element                    ${lnk_Gestionnaire_Modeles}

Créer et Supprimer Propriété
    [Arguments]    ${prop}
    Créer une propriété dans un aspect
    ...    ${MODEL_DATA}[nom_modele]
    ...    ${MODEL_DATA}[prefixe]:${ASPECT_DATA}[nom_aspect]
    ...    ${prop}[nom_prop]
    ...    ${prop}[etiquette_prop]
    ...    ${EMPTY}
    Wait Until Element Is Visible    ${lnk_Outils_Admin}    10s
    Click Element                    ${lnk_Outils_Admin}
    Wait Until Element Is Visible    ${lnk_Gestionnaire_Modeles}    10s
    Click Element                    ${lnk_Gestionnaire_Modeles}
    Supprimer une propriété dans un aspect
    ...    ${MODEL_DATA}[nom_modele]
    ...    ${MODEL_DATA}[prefixe]:${ASPECT_DATA}[nom_aspect]
    ...    ${prop}[nom_prop]

Postconditions
    Supprimer un aspect dans un modèle
    ...    ${MODEL_DATA}[nom_modele]
    ...    ${ASPECT_DATA}[nom_aspect]
    Supprimer un modèle    ${MODEL_DATA}[nom_modele]
    Logout