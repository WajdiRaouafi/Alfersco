Feature: RQ3.BF1 - Recherche de sites

  Scenario: RQ3.BF1.4 - Demander a rejoindre un site modere

    # === PRE-CONDITIONS (profil admin) ===
    Given le navigateur est ouvert
    And l'administrateur se connecte sur Alfresco
    And l'administrateur cree un nouveau site modere
    And l'administrateur cree un nouvel utilisateur
    And l'administrateur se deconnecte

    # === CAS DE TEST (nouvel utilisateur) ===
    When le nouvel utilisateur se connecte sur Alfresco
    And le nouvel utilisateur ouvre la Recherche de sites via le menu Sites
    And le nouvel utilisateur clique sur le bouton Rechercher
    And le nouvel utilisateur clique sur Demander a rejoindre pour le site cree
    Then un message de succes de la demande est affiche

    # === POST-CONDITIONS (profil admin) ===
    And l'administrateur se reconnecte sur Alfresco
    And l'administrateur supprime le site cree
#    And l'administrateur supprime le nouvel utilisateur cree
    And l'administrateur se deconnecte
