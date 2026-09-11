# SFLIGHT Dynpro vers abap2UI5

Ce dossier contient un exemple de conversion d'une logique SAP Dynpro basée sur la table `SFLIGHT` vers une petite application web ABAP avec `abap2UI5`.

L'objectif est de montrer comment reproduire un écran de liste puis un écran de détail, en gardant la logique métier simple et en utilisant le framework UI5 depuis ABAP.

## Contexte

Le projet part d'un cas classique SAP :

- lecture des vols dans la table `SFLIGHT`
- sélection par code de compagnie aérienne (`CARRID`)
- affichage d'une liste de vols
- navigation vers le détail d'un vol
- interface utilisateur construite en ABAP avec `z2ui5`

## Structure du dossier

- `snapshot-2026-09-11/` : copie des artefacts générés ou exportés de la source
- `TRACE.md` : historique des fichiers générés
- `zcl_sflight_dynpro_service.clas.abap` : service ABAP qui lit les données de `SFLIGHT`
- `zcl_abap2ui5_sflight_dynpro.clas.abap` : application principale de type `z2ui5_if_app`
- `*.clas.xml` : métadonnées XML associées aux classes ABAP

## Comportement principal

L'application propose :

1. un champ `CARRID` pour filtrer les vols
2. un bouton de rafraîchissement pour charger les lignes
3. un tableau de vols avec colonnes comme compagnie, connexion, date, prix, devise et places
4. un clic sur une ligne pour ouvrir l'écran de détail
5. un écran de détail affichant les informations du vol sélectionné
6. des boutons de retour et de sortie

## Rôle des classes

### `zcl_sflight_dynpro_service`
Cette classe encapsule l'accès aux données SAP.

Elle expose une méthode `get_flights` qui réalise un `SELECT` sur la table `SFLIGHT` selon le code compagnie fourni.

### `zcl_abap2ui5_sflight_dynpro`
Cette classe représente l'application UI.

Elle gère :

- l'initialisation du service
- le chargement des vols
- le changement d'écran (`0100` / `0200`)
- la construction du XML UI5
- l'interaction avec le client ABAP UI5

## Exemple de flux

- l'utilisateur saisit une compagnie, par exemple `LH`
- la méthode `load_flights` appelle le service
- les résultats sont stockés dans une table interne
- l'écran `0100` affiche cette liste
- l'utilisateur clique sur un vol
- `navigate_to_detail` charge la ligne sélectionnée et affiche l'écran `0200`

## Pré-requis

Pour faire fonctionner ce projet, il faut un environnement ABAP adapté à `abap2UI5` / `z2ui5`, avec les objets de base suivants :

- classes ABAP activables
- accès à la table `SFLIGHT`
- framework `abap2UI5` ou `z2ui5` disponible dans le système

## Remarque

Ce dossier est un snapshot de travail ou de génération, utile pour documenter et examiner la transformation d'une logique Dynpro vers une interface moderne en ABAP UI5.

---

Ce README sert de point d'entrée pour comprendre la logique, les fichiers générés et le parcours fonctionnel de l'application.
