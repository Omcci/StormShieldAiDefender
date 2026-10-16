require('dotenv').config();

const env = {
  nodeEnv: process.env.NODE_ENV || 'development',
  port: Number(process.env.PORT) || 5000,
  databaseUrl:
    process.env.DATABASE_URL || 'postgresql://postgres:postgres@localhost:5432/stormshieldai_db',
  corsOrigin: process.env.CORS_ORIGIN || '*',
};

module.exports = { env };
