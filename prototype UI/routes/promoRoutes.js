const express = require('express');
const router = express.Router();
const db = require('../config/db');

// 获取所有促销活动
router.get('/', async (req, res) => {
    try {
        const [promotions] = await db.query(`
            SELECT 
                id,
                name,
                discount,
                DATE_FORMAT(start_date, '%Y-%m-%d') as start_date,
                DATE_FORMAT(end_date, '%Y-%m-%d') as end_date,
                created_at
            FROM promotions 
            ORDER BY created_at DESC
        `);
        
        // 记录日志
        await db.query(
            'INSERT INTO logs (action, details, username) VALUES (?, ?, ?)',
            ['GET_PROMOTIONS', JSON.stringify({ count: promotions.length }), req.headers.username]
        );
        
        res.json({ success: true, promotions });
    } catch (error) {
        console.error('Error fetching promotions:', error);
        res.status(500).json({ success: false, error: error.message });
    }
});

// 获取单个促销活动
router.get('/:id', async (req, res) => {
    try {
        const [promotions] = await db.query(`
            SELECT 
                id,
                name,
                discount,
                DATE_FORMAT(start_date, '%Y-%m-%d') as start_date,
                DATE_FORMAT(end_date, '%Y-%m-%d') as end_date,
                created_at
            FROM promotions
            WHERE id = ?
        `, [req.params.id]);
        
        // 记录日志
        await db.query(
            'INSERT INTO logs (action, details, username) VALUES (?, ?, ?)',
            ['GET_PROMOTION', JSON.stringify({ id: req.params.id }), req.headers.username]
        );
        
        if (promotions.length === 0) {
            return res.status(404).json({ success: false, error: 'Promotion not found' });
        }

        res.json({ success: true, promotion: promotions[0] });
    } catch (error) {
        console.error('Error fetching promotion:', error);
        res.status(500).json({ success: false, error: error.message });
    }
});

// 添加新促销活动
router.post('/', async (req, res) => {
    const { name, discount, start_date, end_date } = req.body;

    // 基本验证
    if (!name || !discount || !start_date || !end_date) {
        return res.status(400).json({
            success: false,
            error: 'Missing required fields'
        });
    }

    try {
        // 插入新促销活动
        const [result] = await db.query(`
            INSERT INTO promotions (name, discount, start_date, end_date)
            VALUES (?, ?, ?, ?)
        `, [name, discount, start_date, end_date]);

        // 记录日志
        await db.query(
            'INSERT INTO logs (action, details, username) VALUES (?, ?, ?)',
            ['ADD_PROMOTION', JSON.stringify({ promotion: { id: result.insertId, name, discount, start_date, end_date } }), req.headers.username]
        );
        
        // 获取新创建的促销详情
        const [newPromotion] = await db.query(
            `SELECT 
                id,
                name,
                discount,
                DATE_FORMAT(start_date, '%Y-%m-%d') as start_date,
                DATE_FORMAT(end_date, '%Y-%m-%d') as end_date,
                created_at
            FROM promotions
            WHERE id = ?`,
            [result.insertId]
        );

        res.json({
            success: true,
            promotion: newPromotion[0]
        });
    } catch (error) {
        console.error('Error creating promotion:', error);
        res.status(500).json({
            success: false,
            error: error.message
        });
    }
});

// 更新促销活动
router.put('/:id', async (req, res) => {
    const promotionId = req.params.id;
    const { name, discount, start_date, end_date } = req.body;

    // 基本验证
    if (!name || !discount || !start_date || !end_date) {
        return res.status(400).json({
            success: false,
            error: 'Missing required fields'
        });
    }

    try {
        const [result] = await db.query(`
            UPDATE promotions 
            SET name = ?, discount = ?, start_date = ?, end_date = ?
            WHERE id = ?
        `, [name, discount, start_date, end_date, promotionId]);

        // 记录日志
        await db.query(
            'INSERT INTO logs (action, details, username) VALUES (?, ?, ?)',
            ['UPDATE_PROMOTION', JSON.stringify({ id: promotionId, updates: { name, discount, start_date, end_date } }), req.headers.username]
        );
        
        if (result.affectedRows === 0) {
            return res.status(404).json({ 
                success: false, 
                error: 'Promotion not found'
            });
        }

        // 获取更新后的促销详情
        const [updatedPromotion] = await db.query(
            `SELECT 
                id,
                name,
                discount,
                DATE_FORMAT(start_date, '%Y-%m-%d') as start_date,
                DATE_FORMAT(end_date, '%Y-%m-%d') as end_date,
                created_at
            FROM promotions
            WHERE id = ?`,
            [promotionId]
        );

        res.json({
            success: true,
            promotion: updatedPromotion[0]
        });
    } catch (error) {
        console.error('Error updating promotion:', error);
        res.status(500).json({
            success: false,
            error: error.message
        });
    }
});

// 删除促销活动
router.delete('/:id', async (req, res) => {
    try {
        const [result] = await db.query('DELETE FROM promotions WHERE id = ?', [req.params.id]);
        
        // 记录日志
        await db.query(
            'INSERT INTO logs (action, details, username) VALUES (?, ?, ?)',
            ['DELETE_PROMOTION', JSON.stringify({ id: req.params.id }), req.headers.username]
        );
        
        if (result.affectedRows === 0) {
            return res.status(404).json({ 
                success: false, 
                error: 'Promotion not found'
            });
        }

        res.json({ success: true });
    } catch (error) {
        console.error('Error deleting promotion:', error);
        res.status(500).json({
            success: false,
            error: error.message
        });
    }
});

module.exports = router;
