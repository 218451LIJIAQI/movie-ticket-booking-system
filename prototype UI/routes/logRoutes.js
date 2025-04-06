const express = require('express');
const router = express.Router();
const pool = require('../db');

// 添加日志
router.post('/api/logs', async (req, res) => {
    try {
        const { action, details, username } = req.body;
        const timestamp = new Date();
        
        const query = `
            INSERT INTO logs (action, details, username, timestamp)
            VALUES ($1, $2, $3, $4)
            RETURNING *
        `;
        
        const result = await pool.query(query, [action, details, username, timestamp]);
        res.json({ success: true, log: result.rows[0] });
    } catch (error) {
        console.error('Error adding log:', error);
        res.status(500).json({ success: false, error: error.message });
    }
});

// 获取日志列表
router.get('/api/logs', async (req, res) => {
    try {
        const query = `
            SELECT * FROM logs 
            ORDER BY timestamp DESC
            LIMIT 100
        `;
        
        const result = await pool.query(query);
        res.json({ success: true, logs: result.rows });
    } catch (error) {
        console.error('Error fetching logs:', error);
        res.status(500).json({ success: false, error: error.message });
    }
});

module.exports = router;
