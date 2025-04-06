const db = require('../config/db');

/**
 * 记录API操作日志
 * @param {string} action - API操作类型
 * @param {object} details - 操作详细信息
 * @param {string} username - 操作用户
 */
async function logAction(action, details, username = 'system') {
    try {
        await db.query(
            'INSERT INTO logs (action, details, username) VALUES (?, ?, ?)',
            [action, JSON.stringify(details), username]
        );
    } catch (error) {
        console.error('Error logging action:', error);
    }
}

module.exports = {
    logAction
};
