# Contributing to StormShield AI Defender

Merci de contribuer au projet **StormShield AI Defender** !

Ce document décrit les bonnes pratiques à respecter afin de garantir une base de code propre, maintenable et conforme au Plan d'Assurance Qualité (PAQ).

---

# Workflow Git

Le projet utilise le workflow Git suivant :

```
main
└── dev
    ├── feature/<nom-feature>
    ├── fix/<nom-correctif>
    ├── hotfix/<nom-hotfix>
    └── docs/<nom-documentation>
```

* `main` : version stable.
* `dev` : branche principale de développement.
* `feature/*` : nouvelles fonctionnalités.
* `fix/*` : corrections de bugs.
* `hotfix/*` : corrections urgentes.
* `docs/*` : documentation.

Aucun développement ne doit être effectué directement sur `main` ou `dev`.

---

# Création d'une branche

Créer une branche à partir de `dev`.

```bash
git checkout dev
git pull
git checkout -b feature/nom-feature
```

Exemple :

```bash
feature/log-parser
feature/dashboard-alerts
fix/api-timeout
docs/update-readme
```

---

# Convention de commits

Les commits doivent être clairs et respecter la convention suivante :

```
feat:
fix:
docs:
refactor:
test:
style:
chore:
```

Exemples :

```text
feat: add anomaly detection service

fix: correct API authentication

docs: update installation guide

test: add backend unit tests

refactor: simplify log parser
```

---

# Pull Requests

Avant toute Pull Request :

* synchroniser sa branche avec `dev` ;
* vérifier que le projet compile ;
* exécuter les tests ;
* vérifier le formatage du code.

Chaque Pull Request doit :

* décrire les modifications réalisées ;
* référencer le ticket GitHub correspondant ;
* être approuvée par au moins un autre membre de l'équipe.

Aucune Pull Request ne sera fusionnée si les tests échouent.

---

# Standards de développement

## Backend

* Python 3.x
* FastAPI
* Respect de la norme PEP 8
* Formatage avec Ruff (ou Black selon le projet)

## Frontend

* React
* ESLint
* Composants réutilisables
* Nommage explicite des composants

---

# Tests

Toute nouvelle fonctionnalité doit être accompagnée de tests.

Objectifs :

* Backend : **100 %** de couverture.
* Frontend : **≥ 30 %** de couverture.

Les tests sont exécutés automatiquement via GitHub Actions.

---

# Documentation

Toute évolution du projet doit mettre à jour si nécessaire :

* README.md
* Documentation API
* Documentation utilisateur
* PAQ
* CDC

Le code doit être suffisamment documenté pour être compris par l'ensemble de l'équipe.

---

# Qualité du code

Avant toute Pull Request, vérifier :

* Respect des conventions de nommage.
* Aucun code mort.
* Aucun secret (clé API, mot de passe, token) dans le dépôt.
* Aucun commentaire de debug.
* Respect de l'architecture du projet.

---

# Gestion des tickets

Chaque fonctionnalité ou correction doit être associée à un ticket GitHub Projects.

Le ticket doit préciser :

* le besoin ;
* les critères d'acceptation ;
* les tâches réalisées ;
* les éventuelles limitations.

---

# Sécurité

Étant donné que le projet manipule des données de cybersécurité :

* ne jamais publier de secrets Git ;
* utiliser des variables d'environnement ;
* ne jamais pousser de données sensibles ;
* respecter les règles de sécurité définies dans le PAQ.

---

# Besoin d'aide ?

En cas de question :

* ouvrir une Discussion GitHub ;
* contacter le Lead du pôle concerné ;
* échanger lors du Daily Scrum.

Merci de contribuer au projet **StormShield AI Defender** !
