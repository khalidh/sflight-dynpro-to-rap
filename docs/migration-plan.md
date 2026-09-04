# Plan de migration

## Phase 1 — Legacy Dynpro

Application ABAP classique avec :

- programme exécutable ;
- écrans Dynpro 0100 et 0200 ;
- PBO ;
- PAI ;
- GUI Status ;
- accès aux tables SFLIGHT.

## Phase 2 — Refactoring

Extraire la logique métier et l'accès aux données dans des classes ABAP.

## Phase 3 — CDS

Créer les CDS View Entities nécessaires.

## Phase 4 — RAP

Créer :

- Root View Entity ;
- Projection View ;
- Behavior Definition ;
- Behavior Implementation ;
- validations ;
- actions ;
- determinations.

## Phase 5 — OData

Créer :

- Service Definition ;
- Service Binding ;
- OData V4.

## Phase 6 — Fiori Elements

Créer :

- List Report ;
- Object Page.

## Correspondances

| Legacy | Moderne |
|---|---|
| SELECT | CDS View Entity |
| Dynpro | Fiori Elements |
| PBO | Lecture via RAP/CDS |
| PAI | RAP Behavior |
| USER_COMMAND | RAP Action |
| Screen 0100 | List Report |
| Screen 0200 | Object Page |
| SAP GUI | Browser / Fiori |
