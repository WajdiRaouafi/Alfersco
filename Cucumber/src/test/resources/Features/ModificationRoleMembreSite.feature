Feature: RQ3.BF4 - Membres du site

  Scenario: RQ3.BF4.2 - Modifier le role d'un utilisateur

    # === PRE-CONDITIONS ===
    Given le navigateur est ouvert
    And l'administrateur se connecte sur Alfresco
    And l'administrateur cree un nouveau site modere
    And l'administrateur cree un nouvel utilisateur
    And l'administrateur ajoute le nouvel utilisateur au site avec le role Collaborateur

    # === CAS DE TEST ===
    When l'administrateur navigue vers la page des membres du site
    And l'administrateur change le role de l'utilisateur en Gestionnaire
    Then le role de l'utilisateur est Gestionnaire

    # === POST-CONDITIONS ===
    And l'administrateur supprime le site cree
    And l'administrateur supprime definitivement le site de la corbeille
    And l'administrateur se deconnecte
