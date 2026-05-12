*** Settings ***
Library          SeleniumLibrary
Resource         ./resources/keywords/K46_Talel_Login.robot
Resource         ./resources/keywords/K47_Talel_Logout.robot
Resource         ./resources/keywords/K24_Favoris_Dossier.robot
Resource         ./resources/keywords/K25_Favoris_Fichier.robot
Variables        ./resources/data/variables.py
Suite Setup      Préconditions
Suite Teardown   Postconditions
Test Template    Créer Fichier et Définir Favori

*** Variables ***
${URL}           http://172.16.132.248
${BROWSER}       chrome
${USERNAME}      admin
${PASSWORD}      KwiSW3b23Zvp

*** Test Cases ***
RQ2.BF9.1 - Fichier 1    ${FICHIER_DATA_1}
RQ2.BF9.1 - Fichier 2    ${FICHIER_DATA_2}
RQ2.BF9.1 - Fichier 3    ${FICHIER_DATA_3}

*** Keywords ***
Préconditions
    Login    ${URL}/share/page    ${BROWSER}    ${USERNAME}    ${PASSWORD}
    Naviguer vers Mes Fichiers
    Créer un dossier dans Mes Fichiers    ${FAVORI_DOSSIER}

Créer Fichier et Définir Favori
    [Arguments]    ${fichier}
    Naviguer vers Mes Fichiers
    Entrer dans un dossier                     ${FAVORI_DOSSIER}
    Créer un fichier texte dans un dossier     ${fichier}[nom_fichier]
    Définir fichier comme favori
    Vérifier fichier est favori

Postconditions
    FOR    ${fichier}    IN    @{FICHIER_LIST}
        Naviguer vers Mes Fichiers
        Entrer dans un dossier                  ${FAVORI_DOSSIER}
        Supprimer un fichier dans un dossier    ${fichier}[nom_fichier]
    END
    Naviguer vers Mes Fichiers
    Supprimer un dossier dans Mes Fichiers    ${FAVORI_DOSSIER}
    Logout
