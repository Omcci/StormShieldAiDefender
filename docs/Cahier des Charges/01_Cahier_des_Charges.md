# CAHIER DES CHARGES - StormShield AI Defender

## 1. Présentation du Projet et Objectifs

**StormShield AI Defender** est une solution cyber hybride visant à intégrer une couche d'Intelligence Artificielle au sein de l'écosystème matériel Stormshield.

### 1.1. Naissance du projet

**StormShield AI Defender** s'inscrit dans le projet Epitech T-ESP-800. Une équipe répartie entre le pôle IA et le pôle Cyber travaille en lien avec l'écosystème Stormshield pour concevoir une brique logicielle d'IA défensive complémentaire aux pare-feux déjà déployés.

### 1.2. Contexte

Les équipes Blue Team doivent traiter un volume croissant de logs firewall, face à des attaques de plus en plus comportementales, alors que la défense repose encore surtout sur des **règles statiques**. Le projet vise à ajouter une **couche d'IA défensive** aux pare-feux Stormshield : la solution complète le boîtier existant, elle ne le remplace pas.

### 1.3. Objectifs du projet

- Améliorer le travail des équipes Blue Team par la **détection comportementale** des menaces.
- Réduire le temps passé à analyser manuellement les logs Stormshield.
- Proposer, puis automatiser sous contrôle administrateur, certaines **réponses** (blocage IP, règle firewall).
- Anticiper les risques à partir de l'historique des événements de sécurité.
- Documenter et tracer les décisions IA (gouvernance, audit).

Les exigences fonctionnelles détaillées sont en section 3. Les spécifications non fonctionnelles (performance, sécurité, qualité du code) sont en section 4.2.

### 1.4. Étude de marché

Le marché de la cybersécurité est marqué par la hausse du volume d'événements à analyser et du coût des incidents. Les plateformes généralistes (SIEM, XDR, SOAR) couvrent un large périmètre mais restent souvent coûteuses et peu adaptées à un pare-feu précis. Par ailleurs, les grands éditeurs firewall intègrent progressivement de l'IA et s'appuient souvent sur des modules ou plateformes complémentaires (SOAR, SIEM).
**Peu de solutions combinent une couche IA défensive dédiée et une intégration native à l'écosystème Stormshield** ; la plupart des acteurs restent des plateformes généralistes ou des offres liées à un autre éditeur. **StormShield AI Defender** vise ce créneau complémentaire : une brique logicielle connectée aux pare-feux Stormshield pour les équipes Blue Team.

Selon le rapport IBM Cost of a Data Breach Report 2025 [1] :

- Coût moyen d'une violation de données en 2025 : **4,44 M$**.
- Usage intensif de l'IA en sécurité : réduction moyenne du coût d'incident de **1,9 M$** par rapport aux organisations qui n'en disposent pas.
- Cycle de vie d'une violation (identifier + contenir) réduit de **80 jours** en moyenne lorsque l'IA est intégrée au SOC [2].
- Parmi les organisations ayant subi un incident lié à l'IA : **97 %** manquaient de contrôles d'accès adaptés ; **63 %** n'avaient pas de politique de gouvernance IA.

En France, le coût moyen d'une violation atteint **3,59 M€** [3]. Par ailleurs, **65 %** des dirigeants français placent la cybersécurité parmi leurs trois priorités stratégiques [4].

Ces chiffres motivent le projet. Ils ne constituent pas des performances démontrées par notre solution (voir sources [1] à [4] en fin de document).

**Comparatif fonctionnel (état du marché vs cible projet)**

*Marché : **N** = natif · **P** = partiel · **M** = via module externe · **—** = non natif*

*StormShield AI Defender : **C** = cible projet · **R** = roadmap*

| Critère | Stormshield SNS | Palo Alto NGFW | Fortinet FortiGate | Check Point | StormShield AI Defender |
| :------ | :-------------: | :------------: | :----------------: | :---------: | :---------------------: |
| Règles statiques / signatures | N | N | N | N | **C** |
| Détection comportementale IA | — | P | P | P | **C** |
| Scoring de menace | — | P | P | P | **C** |
| Corrélation d'alertes | P | M | M | P | **C** |
| Blocage IP automatisé | P | M | M | M | **C** |
| Génération auto. de règles FW | — | — | P | — | **C** |
| Traçabilité / audit des décisions IA | — | P | P | — | **C** |
| Analyse prédictive | — | P | P | P | **R** |
| Pentesting IA automatisé | — | — | — | — | **R** |

*Ce comparatif décrit un positionnement fonctionnel, pas une certification de performance. **C** = prévu dans le périmètre de livraison actuel ; **R** = évolution future (analyse prédictive, pentest IA).*



## 1.5. Exigences de Sécurité & Gouvernance IA

Le rapport IBM 2025 relève des lacunes de gouvernance IA [1] :

- 63% des organisations n'ont pas de politique de gouvernance IA.
- 97% des violations liées à l'IA ont montré l'absence de contrôles d'accès appropriés.

**Exigences spécifique à ajouter :**

**Gouvernance IA**

- Politique d'accès IA définie et documentée
- Mécanismes de supervision et contrôle des modèles IA
- Audit et traçabilité systématique des décisions IA

## 1.6. Indicateurs et KPI

Objectifs de pilotage du projet (distincts de l'étude de marché, section 1.4, et des objectifs de conception, section 4.2) :

| KPI projet | Objectif |
| :--------- | :------- |
| Pipeline ingestion → alerte | Chaîne fonctionnelle sur un scénario de référence en lab |
| Délai log Syslog → détection d'anomalie | Délai mesuré et documenté en lab ; compatible avec une réponse automatisée perçue comme rapide |
| Qualité des alertes | Réduction observable du bruit par rapport à une remontée brute des logs, sur le dataset disponible |
| Couverture tests automatisés | Tests présents sur les modules critiques livrés (ingestion, API, pipeline IA) |
| Disponibilité backend | Service relançable et stable sur la durée des démonstrations en lab |
| Traçabilité des actions IA | Chaque action automatique est journalisée et consultable |                     |

## 1.7. Analyse des Risques

| Risque                                 | Probabilité | Impact      | Mitigation                                     |
| :------------------------------------- | :----------- | :---------- | :--------------------------------------------- |
| Manque de gouvernance                  | Elevée      | Critique    | Implémenter RBAC, log IA, audit systématique |
| Faux positifs IA perturbant production | Moyenne      | Haute       | Seuils ajustables, validation analyse          |
| Non-conformité réglementaire RGPD    | Moyenne      | Très Haute | Chiffrage, ACL, Data minimization              |
| Adoption lente des automatisations SOC | Faible       | Moyen       | UX simplifiée, formation                      |

---

## 2. Structuration du Produit (PBS & WBS)

Afin de garantir une gestion de projet rigoureuse, la réalisation est découpée selon une structure hiérarchique précise.

### 2.1. PBS (Product Breakdown Structure) - _Vue Macro_

- **A. IA Cyber Defense Core** (Détection, Réponse, Prédiction, Self-learning, Pentesting)
- **B. Intégration Stormshield** (Collecte Syslog, API/SDK, Gestion des règles, Monitoring)
- **C. Interface & UX** (Dashboard, Alertes, Configuration)
- **D. Infrastructure & Backend** (Pipeline IA, BDD, Corrélation, SOAR)
- **E. Qualité & Documentation** (Spécifications, Docs, Tests, CI/CD)

### 2.2. WBS (Work Breakdown Structure) - _Vue Détaillée (Extrait des Tâches)_

_(Pour le WBS complet, se référer aux tickets GitHub Projects de l'équipe et au fichier `WBS.md`)._

- **A1.** Analyse logs, normalisation, entraînement ML, détection temps réel, scoring.
- **A2.** Cartographie actions, moteur règles IA, push API, rollback, journalisation.
- **B1.** Récupération Syslog, filtrage, connexion IDS.
- **B2.** Étude doc, auth API, pull/push.
- **C1.** Maquette Figma, vue métriques, temps réel.
- **D1/D2.** Collecte, feature engineering, déploiement modèle, schéma BDD sécurisé.

---

## 3. Spécifications Fonctionnelles & Critères d'Acceptation

Cette section traduit les fonctionnalités attendues par l'utilisateur final (Blue Team) en exigences mesurables (**User Stories** et **Critères d'Acceptation**).

### Module A : IA Cyber Defense Core

**User Story A1 (Détection) :** _En tant qu'analyste SOC, je veux que le système analyse automatiquement le trafic Stormshield afin d'identifier les menaces sans fouiller dans les logs._

- **Critères d'Acceptation :**
  - L'interface affiche une alerte claire dès qu'un comportement suspect est détecté.
  - Chaque alerte est accompagnée d'un "Score de danger" (ex: 0 à 100%).
  - Le système génère un résumé lisible de la menace détectée.

**User Story A2 (Réponse Automatisée) :** _En tant qu'administrateur, je veux que l'IA bloque automatiquement les menaces critiques pour réduire mon temps de réaction._

- **Critères d'Acceptation :**
  - L'IA déclenche une action (blocage IP, isolement, création règle) via l'API Stormshield si le seuil critique est atteint.
  - Un toggle (bouton) permet à l'admin d'activer/désactiver le mode "Auto-mitigation".
  - Toutes les actions automatiques sont tracées dans un historique consultable.

**User Story A3 & A5 (Prédiction & Pentest) :** _En tant que RSSI, je veux que l'outil simule des failles et anticipe les attaques pour corriger ma configuration._

- **Critères d'Acceptation :**
  - L'outil génère des alertes préventives basées sur l'historique.
  - Un rapport de risque détaillé est généré après chaque pentest IA automatisé avec des recommandations claires.

### Module B & C : Intégration & Expérience Utilisateur

**User Story B1 & B2 (Intégration Transparente) :** _En tant qu'ingénieur réseau, je veux que l'outil se connecte au firewall sans configuration scriptée complexe._

- **Critères d'Acceptation :**
  - Le module ingère les logs via Syslog UDP 514 sans intervention manuelle post-setup.
  - L'outil s'authentifie via l'API/SDK officiel Stormshield sans erreur de timeout.

**User Story C1 (Dashboard) :** _En tant que Blue Team, je veux un tableau de bord unique pour voir l'état de mon réseau en 24/7._

- **Critères d'Acceptation :**
  - L'interface regroupe : menaces détectées, actions prises, recommandations et état du firewall.
  - Le Moteur de Corrélation (D3) a réduit le bruit : 50 événements bruts similaires doivent remonter comme **1 seule alerte consolidée**.

---

## 4. Spécifications Techniques et Assurance Qualité (PAQ)

Pour répondre aux standards de l'ingénierie logicielle et sécuritaire, les éléments suivants définissent nos normes de qualité.

### 4.1. Exigences Fonctionnelles

Les exigences fonctionnelles détaillées sont définies en **section 3** (user stories A1 à C1). Synthèse :

| Module | Exigence fonctionnelle                                                       |
| :----- | :--------------------------------------------------------------------------- |
| A1     | Détection comportementale avec alerte, score et résumé                    |
| A2     | Réponse automatisée via API Stormshield, avec mode activable/désactivable |
| A3/A5  | Alertes préventives et rapport de risque (roadmap selon avancement)         |
| B1/B2  | Ingestion Syslog et authentification API Stormshield                         |
| C1     | Dashboard de supervision et corrélation d'alertes                           |

### 4.2. Exigences Non Fonctionnelles

Les spécifications non fonctionnelles décrivent **comment** le logiciel doit se comporter, **en complément** des objectifs du projet (section 1.3). Ce sont des exigences mesurables sur notre application.

**Performance**

- Délai entre réception d'un log Syslog (B1) et détection d'une anomalie (A1.4) : objectif **< 500 ms** en lab.
- Temps maximal de réponse automatisée (action firewall) : objectif **< 3 s**.
- Chargement initial du dashboard : utilisation fluide sur poste analyste de référence (objectif de conception).
- Capacité de traitement : **à définir** selon l'environnement lab (logs/seconde).

**Disponibilité et exploitation**

- Backend dockerisé avec redémarrage automatique en cas de crash.
- Disponibilité : objectif indicatif en lab, selon périmètre réellement déployé.

**Sécurité**

- Communications chiffrées (TLS 1.2 minimum).
- Base de données PostgreSQL chiffrée (historique alertes, modèles IA).
- Accès API Stormshield par token sécurisé.
- Gestion des rôles utilisateurs (RBAC).
- Journalisation des actions automatiques.
- Protection des modèles IA contre modification non autorisée.

**Maintenabilité et qualité du code**

- Architecture **modulaire** : collecte, moteur IA, backend et interface séparés.
- Code conforme aux **conventions** du projet (PEP 8 pour Python).
- Couverture tests automatisés : objectif **≥ 70 %** sur le périmètre livré.
- Code review obligatoire avant merge.

**Utilisabilité**

- Interface web accessible en intranet uniquement.
- Alertes lisibles (score + résumé).

**Portabilité**

- Déploiement possible sur machine virtuelle Linux.
- Moteur IA isolé du reste pour limiter les impacts sécurité.

### 4.3. Exigences Techniques

- **Architecture système :**

  - Module de collecte de logs
  - Moteur d'IA indépendant exécuté sur un serveur dédié
  - Backend applicatif assurant la communication entre l'IA et le FW
  - Une interface web accessible en intranet uniquement
- **Environnement technique :**

  - Python (Backend + IA)
  - Framework API : FastAPI
  - ML : à préciser selon périmètre livré
  - Frontend : React (cf. PAQ)
  - Base de données : PostgreSQL (cf. PAQ)
- **Protocoles & Interfaces :**

  - Collecte des logs via Syslog UDP/TCP
  - Communication IA - Backend via API REST
  - Authentification API par token sécurisé
  - Communication sécurisée en HTTPS
- **Contraintes Techniques :**

  - Compatibilité obligatoire avec API Stormshield
  - Déploiement possible sur machine virtuelle Linux
  - Modularité permettant l'évolution des modèles IA
  - Isolation du moteur IA pour limiter les impacts sécurité

### 4.4. Éléments de Qualité et "Definition of Done" (DoD)

Un ticket du WBS ne sera considéré comme terminé et validé que si les conditions de qualité suivantes sont respectées :

1. **Code Review :** Toute Pull Request sur GitHub (E4) doit être approuvée par au moins 1 autre développeur (Pôle IA ou Cyber).
2. **Tests Unitaires (E3) :** Le code du pipeline IA et des scripts API doit passer les tests automatisés (Coverage minimum attendu : 70%).
3. **Tests d'Intégration (E3.3) :** Une simulation d'attaque contrôlée (A5.2) doit confirmer que la règle firewall a bien été poussée en production sur le boîtier Stormshield (Sandbox ou Prod).
4. **Documentation (E2) :** Le README et la documentation de l'API (Swagger/Postman) doivent être mis à jour après chaque nouvelle fonctionnalité.

---

## Sources et références

### Étude de marché et gouvernance IA

| N° | Source                                                     | Données citées                                                                      | Lien                                                                                                                                                                                                                  |
| :-- | :--------------------------------------------------------- | :------------------------------------------------------------------------------------ | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [1] | IBM,*Cost of a Data Breach Report 2025*                  | Coût moyen mondial (4,44 M$), économies IA (1,9 M$), gouvernance IA (63 % / 97 %) | [ibm.com/reports/data-breach](https://www.ibm.com/reports/data-breach)                                                                                                                                                   |
| [2] | IBM, communiqué sur l'IA et les violations (juillet 2025) | Réduction du cycle de vie d'une violation (80 jours)                                 | [newsroom.ibm.com](https://newsroom.ibm.com/2025-07-30-ibm-report-13-of-organizations-reported-breaches-of-ai-models-or-applications,-97-of-which-reported-lacking-proper-ai-access-controls)                            |
| [3] | IBM France, communiqué (juillet 2025)                     | Coût moyen d'une violation en France (3,59 M€)                                      | [fr.newsroom.ibm.com](https://fr.newsroom.ibm.com/Rapport-IBM-13-des-organisations-ont-signale-des-violations-de-modeles-ou-dapplications-dIA,-dont-97-ont-declare-ne-pas-disposer-de-controles-dacces-a-lIA-appropries) |
| [4] | PwC,*Global Digital Trust Insights 2025*                 | Priorité stratégique cybersécurité en France (65 %)                               | [pwc.fr](https://www.pwc.fr/fr/publications/series/global-digital-trust-insights.html)                                                                                                                                   |
