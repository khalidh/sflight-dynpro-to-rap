# Prompt — Migration RAP

Analyser l'application ABAP Dynpro legacy.

Transformer progressivement :

- SELECT en CDS View Entity ;
- logique transactionnelle en RAP ;
- commandes PAI en actions RAP ;
- écran liste en Fiori Elements List Report ;
- écran détail en Object Page.

Préserver le comportement fonctionnel de l'application legacy.

Pour chaque transformation, documenter :

1. l'objet legacy ;
2. son rôle ;
3. son équivalent moderne ;
4. le code cible ;
5. les tests de non-régression.
