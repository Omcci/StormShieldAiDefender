# Backend StormShield AI Defender

## Arborescence

```text
backend/
├── .env.example
├── .gitignore
├── docker-compose.yml
├── package.json
├── README.md
└── src/
    ├── app.js
    ├── server.js
    ├── config/
    │   ├── database.js
    │   └── env.js
    ├── controllers/
    │   └── healthController.js
    ├── middlewares/
    │   └── errorHandler.js
    ├── routes/
    │   ├── health.routes.js
    │   └── index.js
    └── services/
        └── healthService.js
```

## Lancement

1. Installer les dépendances :
   ```bash
   npm install
   ```
2. Copier le fichier d’environnement :
   ```bash
   cp .env.example .env
   ```
3. Démarrer le serveur :
   ```bash
   npm run dev
   ```

## Endpoints de base

- `GET /` : message d’accueil de l’API
- `GET /api/health` : vérifie la disponibilité du service

## Base de données

Le projet est prêt à connecter PostgreSQL via `DATABASE_URL`.
Le fichier `docker-compose.yml` fournit une base Postgres locale pour le développement.
