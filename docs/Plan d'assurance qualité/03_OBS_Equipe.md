# OBS (Organizational Breakdown Structure) & Cartographie des Compétences

## 1. Composition de l'Équipe (7 Membres)

Notre équipe est composée de profils complémentaires, majoritairement spécialisés en Cybersécurité, avec un pôle dédié à l'Intelligence Artificielle et au développement Backend.

Cette structure hybride est un choix stratégique : pour qu'une IA de sécurité soit pertinente, elle doit être entraînée et validée par des experts capables de comprendre les attaques réelles (Blue Team / Red Team), de configurer le matériel (Stormshield) et d'analyser les logs.

## 2. Répartition des Rôles

| Pôle | Rôle | Membre Assigné | Responsabilités | Justification Professionnelle |
| :-- | :-- | :-- | :-- | :-- |
| **ALL** | **Chef de Projet** | _Omcci_ | Pilotage global du projet, coordination des équipes, supervision des livrables, présentation, gestion de projet. | Expérience en gestion de projets techniques en contexte école et entreprise, avec coordination d’équipes pluridisciplinaires. Forte implication depuis plusieurs mois sur des projets IA, bonne maîtrise de la structuration des objectifs, du suivi opérationnel et de l’alignement entre besoins métier et exécution technique. |
| **Pôle IA & Dev** | **Lead AI / Data Scientist** (Chef de projet IA) | _Omcci_ | Architecture du moteur d'IA (Machine Learning), modélisation des comportements anormaux, intégration des modèles de détection. | Compétences solides en algorithmique et montée en compétence continue en IA/Data Science appliquée à la cybersécurité ; capacité à transformer un besoin métier en approche ML pragmatique et testable. |
| **Pôle IA & Dev** | **Lead Backend Engineer** | _Faithgot GLIN-DAYI_ | Développement de l'API, gestion de la base de données, création du connecteur avec l'API Stormshield. | 4 ans d’expérience en développement Python, dont 3 ans de développement backend en environnement Full Stack (alternance) pour assurer un backend robuste et temps réel. |
| **Pôle Cyber** | **Lead SecOps** (Chef de Projet Cyber) | _Reineix_ | Pilotage complet du pôle Cyber, aide à la configuration et administration du FW Stormshield, tests d'intégration API, animation des rituels Agile. | Chef de projet (Gestion de projet et Sécurité) en entreprise depuis un an sur Fil d'Ariane, Conseil au voyageur, Crisenet et sur un projet de 1 an en Licence Cyber. Expérience en gestion de projets sur des sujets internationaux, des équipes et des postes pilotes dans le monde entier. |
| **Pôle Cyber** | **Data Analyst / SOC Analyst** | _Bauge_ | Analyse et nettoyage des datasets d'attaques (KDD Cup, PCAP), qualification des logs pour fournir des données d'entraînement saines à l'IA. | J'occupe actuellement un poste d'analyste SOC au sein de la Société Login, sur laquelle j'ai été formé à la gestion sécurisée et à la protection du système d'informations client. |
| **Pôle Cyber** | **Pentester (Red Team)** | _Killian_ | Création de scénarios d'attaques (DDoS, Bruteforce, Exfiltration) pour générer du trafic malveillant et tester la réaction de l'IA en conditions réelles. | Depuis le début de mon master, j'ai réalisé des audits de sécurité et de performance en entreprise, incluant la simulation d'attaques (DDoS, Bruteforce, Exfiltration) pour tester la résilience du Module A5 (détection d'anomalies par IA). Ces audits permettent d'évaluer et d'améliorer les mécanismes de défense et la réactivité du système. |
| **Pôle Cyber** | **Analyste Blue Team (QA & Validation)** | _Noah_ | Définition des règles de scoring (seuil de blocage), validation des faux positifs, tests d'acceptation (Definition of Done). | Expertise défensive permettant de s'assurer que l'IA ne bloque pas le trafic légitime de l'entreprise. Le choix du rôle d’Analyste Blue Team (QA & Validation) s’inscrit dans la continuité de mon parcours en alternance depuis deux ans, durant lequel j’ai développé un socle technique solide en réseaux, systèmes et cybersécurité. |
| **Pôle Dev** | **UX / Dev Frontend (Dashboard)** | _Gabin_ | Conception de l'interface de supervision (Dashboard Blue Team), visualisation des alertes et des logs IA. | 1 an d'alternance en tant que dev full stack sur des projets de logiciels internes (front/back). |

_(Note : Tous les membres du pôle Cyber participeront à la rédaction de la documentation technique, du PAQ et du Cahier des Charges)._

Cette répartition garantit que les développeurs (IA/Back) sont nourris en données de qualité par des experts métiers (Cyber), assurant ainsi un produit final cohérent, réaliste et professionnel.
