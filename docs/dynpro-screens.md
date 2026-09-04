# Dynpro Screens

## Screen 0100

Écran principal.

### Fonctions prévues

- filtre par compagnie aérienne ;
- liste des vols ;
- rafraîchissement ;
- ouverture du détail ;
- retour.

### GUI Status

```text
MAIN100
```

### Commandes

```text
DETAIL
REFRESH
BACK
EXIT
CANCEL
```

### Flow Logic proposé

```abap
PROCESS BEFORE OUTPUT.
  MODULE status_0100.

PROCESS AFTER INPUT.
  MODULE user_command_0100.
```

## Screen 0200

Écran détail.

### Champs

- compagnie ;
- connexion ;
- date ;
- prix ;
- devise ;
- sièges maximum ;
- sièges occupés.

### Flow Logic proposé

```abap
PROCESS BEFORE OUTPUT.
  MODULE status_0200.

PROCESS AFTER INPUT.
  MODULE user_command_0200.
```
