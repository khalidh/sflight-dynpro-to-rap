# Architecture Legacy

## Tables utilisées

- SCARR
- SPFLI
- SFLIGHT

## Application cible

```text
Dynpro 0100
    |
    +-- Liste des vols
    |
    +-- Recherche
    |
    +-- Sélection
           |
           v
      Dynpro 0200
           |
           +-- Détail du vol
```

## Architecture initiale

```text
SAP GUI
   |
Dynpro
   |
PBO / PAI
   |
ZCL_SFLIGHT_SERVICE
   |
SFLIGHT
SPFLI
SCARR
```

## Principe

Le Dynpro reste volontairement simple.

La logique d'accès aux données doit progressivement être déplacée vers
des classes ABAP afin de préparer la migration vers CDS et RAP.
