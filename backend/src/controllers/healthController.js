const { getHealthStatus } = require('../services/healthService');

async function getHealth(req, res, next) {
  try {
    const health = await getHealthStatus();
    res.status(200).json({
      success: true,
      data: health,
    });
  } catch (error) {
    next(error);
  }
}

module.exports = {
  getHealth,
};
