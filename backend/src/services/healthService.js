async function getHealthStatus() {
  return {
    status: 'ok',
    service: 'stormshield-ai-defender-api',
    timestamp: new Date().toISOString(),
  };
}

module.exports = { getHealthStatus };
