const app = require('./app');
const { env } = require('./config/env');
const { testDatabaseConnection } = require('./config/database');

async function startServer() {
  try {
    await testDatabaseConnection();
    app.listen(env.port, () => {
      console.log(`Serveur backend démarré sur http://localhost:${env.port}`);
    });
  } catch (error) {
    console.error('Erreur au démarrage du backend :', error.message);
    process.exit(1);
  }
}

startServer();
