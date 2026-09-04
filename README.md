# SFLIGHT Dynpro to RAP

Projet pédagogique de migration SAP :

Classic ABAP / Dynpro
→ Refactoring
→ CDS
→ RAP
→ OData
→ Fiori Elements
→ SAP BTP

## Objectif

Construire une application legacy basée sur SFLIGHT puis la moderniser progressivement.

## Architecture

```text
src/
├── legacy/
├── refactoring/
├── cds/
├── rap/
├── odata/
└── fiori/

docs/
prompts/
scripts/
```

## Étapes

1. Créer l'application SFLIGHT Dynpro.
2. Séparer la logique métier.
3. Introduire CDS.
4. Construire le RAP Business Object.
5. Exposer OData.
6. Créer l'interface Fiori Elements.
7. Préparer la cible BTP.

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
SAP ABAP Developer Trial
```

> Important : les fichiers source ABAP de ce dépôt constituent la base du projet.
> Pour les écrans Dynpro, GUI Status et autres objets Repository complexes,
> il est préférable de laisser abapGit produire la sérialisation finale depuis SAP.
