const { Pool } = require('pg');
const { env } = require('./env');

const pool = new Pool({
  connectionString: env.databaseUrl,
  ssl: env.nodeEnv === 'production' ? { rejectUnauthorized: false } : false,
});

async function testDatabaseConnection() {
  const result = await pool.query('SELECT 1');
  return result.rows[0];
}

module.exports = {
  pool,
  query: (text, params) => pool.query(text, params),
  testDatabaseConnection,
};
