*** Settings ***
Library          SeleniumLibrary
Resource         ./resources/keywords/K46_Talel_Login.robot
Resource         ./resources/keywords/K47_Talel_Logout.robot
Resource         ./resources/keywords/K24_Favoris_Dossier.robot
Resource         ./resources/keywords/K26_AutorisationDossier.robot
Resource         ./resources/keywords/K27_Admin_Groupe.robot
Resource         ./resources/keywords/K28_Admin_SuppressionGroupe.robot
Suite Setup      Préconditions
Suite Teardown   Postconditions

*** Variables ***
${URL}                  http://172.16.132.248
${BROWSER}              chrome
${USERNAME}             admin
${PASSWORD}             KwiSW3b23Zvp
${GROUPE_NOM}           test_groupe
${GROUPE_AFFICHAGE}     Groupe de Test
${DOSSIER_AUTORI}       DossierAutorisations

*** Test Cases ***
RQ2.BF10.1 - Gérer les autorisations d'un dossier
    Naviguer vers Mes Fichiers
    Afficher les détails du dossier         ${DOSSIER_AUTORI}
    Gérer les autorisations du dossier
    Ajouter un groupe aux autorisations     ${GROUPE_NOM}
    Enregistrer les autorisations

*** Keywords ***
Préconditions
    Login                               ${URL}/share/page    ${BROWSER}    ${USERNAME}    ${PASSWORD}
    Naviguer vers Gestion des Groupes
    Créer un groupe                     ${GROUPE_NOM}    ${GROUPE_AFFICHAGE}
    Naviguer vers Mes Fichiers
    Créer un dossier dans Mes Fichiers  ${DOSSIER_AUTORI}

Postconditions
    Naviguer vers Mes Fichiers
    Supprimer un dossier dans Mes Fichiers    ${DOSSIER_AUTORI}
    Supprimer un groupe                       ${GROUPE_NOM}
    Logout
