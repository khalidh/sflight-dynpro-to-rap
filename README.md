# SFLIGHT Dynpro to RAP

Projet pédagogique de migration SAP d’une application legacy basée sur la table `SFLIGHT` vers une architecture moderne ABAP / RAP / Fiori.

## Objectif

Transformer progressivement une logique Dynpro classique en une solution plus moderne basée sur :

- ABAP classique
- refactoring métier
- CDS
- RAP
- OData
- UI Fiori / Fiori Elements
- SAP BTP

## Structure du dépôt

```text
.
├── README.md
├── docs/
├── prompts/
├── scripts/
├── src/
│   ├── cds/
│   ├── fiori/
│   ├── legacy/
│   ├── odata/
│   ├── rap/
│   └── refactoring/
└── .abapgit.xml
```

## Ce qui est déjà présent

### Legacy
Le dossier [src/legacy](src/legacy) contient les objets historiques et les premiers exemples ABAP :

- programme Dynpro legacy
- service `SFLIGHT`
- classes d’initiation `abap2UI5` / `hello world`

### Fiori / UI modernisée
Le dossier [src/fiori](src/fiori) contient les objets plus récents qui reflètent la migration vers une interface moderne :

- `zcl_abap2ui5_sflight_dynpro.clas.abap`
- `zcl_sflight_dynpro_service.clas.abap`

## Etapes de migration

1. Reproduire la logique SAP legacy sur `SFLIGHT`
2. Séparer les responsabilités métier et UI
3. Remplacer progressivement les traitements dynpro par des objets ABAP modulaires
4. Introduire les vues CDS
5. Construire le modèle RAP
6. Exposer les services OData
7. Créer l’interface Fiori Elements
8. Préparer la cible SAP BTP

## Flux de travail

```text
VS Code
   ↓
Git local
   ↓
GitHub
   ↓
abapGit
   ↓
SAP ABAP system
```

## Remarques importantes

- Ce dépôt est pensé pour être exploité avec abapGit.
- La racine de synchronisation ABAP est le dossier [src](src).
- Les objets utiles pour l’import sont ceux structurés comme des artefacts ABAP, notamment sous [src/legacy](src/legacy) et [src/fiori](src/fiori).
- Les dossiers de snapshot ou d’archives ne doivent pas être utilisés comme objets d’import directement.

## Objectif technique

Le projet montre comment migrer une application SAP classique vers une architecture plus moderne, en conservant la logique métier autour de `SFLIGHT` tout en préparant l’UI et l’API pour un usage Fiori / RAP.
