# Plan d'Assurance Qualité (PAQ)

## 1. Choix Technologiques & Justifications

- **Backend & IA : Python + FastAPI.** _Justification :_ Python est le standard industriel pour le Machine Learning.
  FastAPI offre des performances asynchrones idéales pour ingérer des logs en temps réel.
- **Base de Données : PostgreSQL.** _Justification :_ Fiabilité relationnelle pour stocker l'historique des attaques et des actions menées.
- **Frontend : ==React==.** _Justification :_ Réactivité nécessaire pour un tableau de bord de supervision SOC en temps réel.
- **Infra : Docker.** _Justification :_ Facilite le déploiement sur n'importe quel environnement client sans conflits de dépendances.

### Concernant l'infra physique, elle reste à définir ultérieurement.

## 2. Méthodologie

Nous utilisons la méthode **Agile SCRUM**.

- **Sprints :** Cycles de plusieurs semaines à définir.
- **Rituels :** Daily stand-up, Sprint Planning et Review à chaque fin de cycle.
- **Outils :**
  - _Ticketing :_ GitHub Projects.
  - _Communication :_ Canal dédié Teams (split de deux canaux selon spé)
  - _Versioning :_ GitHub (Flow standard : `main`, `develop`, branches `feature/nom-ticket`).
- **Workflow** :
  - Issue créée → ticket déplacé en En cours → développement sur branche feature → PR revue → fusion sur develop → passage en Terminé si la DoD (section 3) est validée.

## 3. Normes et Qualité (Definition of Done)

Un ticket est considéré comme "Terminé" uniquement si :

1. Le code respecte les normes (PEP 8 pour Python, ESLint pour le JS).
2. Le code a été commenté et documenté.
3. Une revue de code (Pull Request) a été approuvée par au moins 1 autre membre.
4. (A définir) Les tests unitaires passent avec succès (Coverage minimum cible : 70%).
5. La fonctionnalité a été fusionnée sur la branche `develop`.

## 4. Gestion des Risques

Les risques projet sont identifiés dès le lancement du développement et sont suivis tout au long du projet. Ils sont réévalués à chaque Sprint Review afin d'adapter les plans d'atténuation si nécessaire.

| Risque identifié                                             |    Impact    | Probabilité | Plan d'atténuation (Plan B)                                                                                                    |
| :------------------------------------------------------------ | :-----------: | :----------: | :------------------------------------------------------------------------------------------------------------------------------ |
| **API Stormshield inaccessible ou complexe**            |    Élevé    |    Moyen    | Utiliser des scripts SSH automatisés en fallback au lieu de l'API REST.                                                        |
| **Faux positifs de l'IA bloquant le réseau**           |    Élevé    |    Forte    | Intégrer un**Mode Audit** permettant à l'IA de proposer des actions sans les appliquer automatiquement.                 |
| **Retard sur le développement du front-end**           |   Modéré   |    Moyen    | Utiliser un template d'administration==React== afin d'accélérer le développement de l'interface.                         |
| **Manque de données d'entraînement pour l'IA**        |    Élevé    |    Moyen    | Constituer un jeu de données à partir de logs simulés et de scénarios d'attaque contrôlés.                                |
| **Non-conformité au RGPD**                             | Très élevé |    Faible    | Limiter les données collectées, sécuriser leur stockage et contrôler les accès aux informations sensibles.                 |
| **Indisponibilité du moteur IA**                       |    Élevé    |    Faible    | Prévoir un mode dégradé où la collecte et la supervision restent opérationnelles sans blocage automatique.                 |
| **Compromission des identifiants de l'API Stormshield** |   Critique   |    Faible    | Stocker les secrets de manière sécurisée, appliquer une rotation régulière des tokens et limiter les privilèges d'accès. |
| **Baisse des performances du modèle IA (Model Drift)** |   Modéré   |    Moyen    | Surveiller les performances du modèle et prévoir un réentraînement périodique avec des données récentes.                 |

## 5. Politique de Tests

### 5.1. Objectif

La politique de tests a pour objectif de garantir la qualité, la fiabilité et la sécurité de **StormShield AI Defender** tout au long du développement. Les tests permettent de vérifier que chaque fonctionnalité répond aux exigences définies dans le cahier des charges, tout en limitant les régressions lors des évolutions du projet.

### 5.2. Stratégie de tests

Le projet repose sur plusieurs niveaux de tests automatisés et manuels.

#### Tests unitaires

Les tests unitaires vérifient le bon fonctionnement des composants logiciels de manière isolée.

Ils concernent principalement :

- les services FastAPI ;
- les modules de traitement des logs ;
- les fonctions du moteur d'IA ;
- les interactions avec la base de données (via des mocks).

Les tests unitaires sont exécutés automatiquement à chaque Pull Request.

**Objectif de couverture :**

- Backend Python : **100 %** de couverture de code.

#### Tests d'intégration

Les tests d'intégration permettent de vérifier les interactions entre les différents composants de l'application.

Ils portent notamment sur :

- la communication entre le frontend ==React== et l'API FastAPI ;
- les échanges avec PostgreSQL ;
- les appels vers l'API Stormshield (ou un environnement de test simulé).

Les tests d'intégration sont exécutés automatiquement dans le pipeline CI.

**Objectif de couverture :**

- Frontend ==React== : **≥ 30 %**.

#### Tests fonctionnels

Les tests fonctionnels permettent de valider les principales fonctionnalités décrites dans le cahier des charges.

Ils vérifient notamment :

- l'ingestion des logs Syslog ;
- la détection d'anomalies par le moteur IA ;
- l'affichage des alertes dans le tableau de bord ;
- la génération des recommandations ;
- le déclenchement des actions automatiques (en environnement de test).

Ces tests sont réalisés avant chaque livraison de sprint.

#### Tests de régression

Avant toute fusion sur la branche `develop`, l'ensemble des tests automatisés est exécuté afin de vérifier que les nouvelles modifications n'ont pas introduit de régressions.

### 5.3. Critères d'acceptation

Une fonctionnalité est considérée comme validée lorsque :

- tous les tests unitaires sont réussis ;
- les tests d'intégration sont validés ;
- aucun défaut critique n'est identifié ;
- la revue de code a été approuvée ;
- les objectifs de couverture de code sont atteints.

Ces critères complètent la **Definition of Done** définie dans le Plan d'Assurance Qualité.

### 5.4. Automatisation

Les tests sont exécutés automatiquement via le pipeline d'intégration continue (CI) lors de chaque Pull Request.

Le pipeline réalise les opérations suivantes :

1. Vérification du style de code (PEP 8, ESLint).
2. Exécution des tests unitaires.
3. Calcul du taux de couverture.
4. Exécution des tests d'intégration.
5. Validation avant autorisation de fusion sur la branche `develop`.

### 5.5. Outils utilisés

| Domaine               | Outil                               |
| --------------------- | ----------------------------------- |
| Tests Backend         | Pytest                              |
| Couverture Backend    | pytest-cov                          |
| Tests Frontend        | Jest /==React== Testing Library |
| Qualité Python       | Ruff                                |
| Qualité JavaScript   | ESLint                              |
| Intégration Continue | GitHub Actions                      |

### 5.6. Gestion des anomalies

Toute anomalie détectée lors des tests fait l'objet d'un ticket GitHub précisant :

- une description du problème ;
- les étapes permettant de reproduire l'erreur ;
- le résultat attendu ;
- le résultat obtenu ;
- la priorité de correction.

Les anomalies critiques doivent être corrigées avant toute mise en pré-production et en production.

## 6. Estimation des coûts liés à la qualité et à l'exploitation

Les activités d'assurance qualité reposent principalement sur des outils open source (Python, FastAPI, ==React==, PostgreSQL, Docker, Pytest, Jest, GitHub Actions), ce qui limite les coûts de licences. Les coûts concernent principalement le temps consacré aux tests, aux revues de code et à la validation.

| Poste                                               |                   Estimation |
| :-------------------------------------------------- | ---------------------------: |
| Mise en place des tests unitaires et d'intégration |            ≈ 8 hommes/jours |
| Revues de code                                      |            ≈ 2 hommes/jours |
| Validation fonctionnelle                            |            ≈ 3 hommes/jours |
| Documentation qualité                              |            ≈ 2 hommes/jours |
| **Effort total Assurance Qualité**           | **≈ 15 hommes/jours** |

### Hypothèse 1 : Déploiement sur AWS

Dans le cas d'un hébergement cloud sur AWS, une architecture adaptée à un environnement de démonstration ou à une PME pourrait être constituée des services suivants :

| Ressource                         |         Coût mensuel estimé |
| :-------------------------------- | ----------------------------: |
| Instance EC2 (Backend + IA)       |                   40 à 80 € |
| Base de données PostgreSQL (RDS) |                   25 à 50 € |
| Stockage (EBS / S3)               |                   10 à 20 € |
| Sauvegardes et trafic réseau     |                   10 à 30 € |
| **Coût mensuel estimé**   | **85 à 180 € / mois** |

### Hypothèse 2 : Déploiement sur infrastructure physique

Dans le cas d'un déploiement sur site (On-Premise), une architecture minimale pourrait être composée de :

| Équipement                                       |               Coût estimé |
| :------------------------------------------------ | --------------------------: |
| Serveur dédié (CPU multicœurs, 32 Go RAM, SSD) |           2 000 à 3 500 € |
| Stockage supplémentaire / sauvegarde             |               300 à 700 € |
| Onduleur (UPS)                                    |               200 à 400 € |
| Switch réseau et câblage (si nécessaire)       |               300 à 800 € |
| **Investissement initial estimé**          | **2 800 à 5 400 €** |

### Hypothèse 3 : Déploiement conteneurisé avec Docker

Dans cette hypothèse, l'ensemble des composants de l'application est exécuté dans des conteneurs Docker sur un poste de travail ou un serveur déjà disponible. Cette architecture est privilégiée pour le développement, les démonstrations et les phases de validation du projet.

| Ressource                                         |      Coût estimé |
| :------------------------------------------------ | -----------------: |
| Docker Engine                                     |            Gratuit |
| Docker Compose                                    |            Gratuit |
| Images Docker (Frontend, Backend, IA, PostgreSQL) |            Gratuit |
| Machine hôte                                     | Matériel existant |
| **Coût d'exploitation**                    |     **0 €** |

**Architecture des conteneurs :**

- Conteneur Frontend (==React==)
- Conteneur Backend (FastAPI)
- Conteneur IA (Machine Learning)
- Conteneur PostgreSQL
- Réseau Docker privé pour les communications internes

Cette solution permet de reproduire facilement l'environnement de développement et de validation sans coût d'infrastructure supplémentaire. Elle est particulièrement adaptée au contexte d'un projet de fin d'études et facilite le déploiement ainsi que la maintenance de l'application.

### Remarques

* Les montants présentés sont donnés à titre indicatif et correspondent à une architecture adaptée au périmètre du projet de fin d'études.
* Les technologies utilisées étant majoritairement open source, aucun coût de licence logicielle n'est prévu.
* Les coûts liés au matériel Stormshield, à la maintenance, au support ou à une montée en charge importante ne sont pas inclus dans ces estimations.
