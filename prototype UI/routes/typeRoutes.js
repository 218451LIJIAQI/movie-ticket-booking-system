const express = require('express');
const router = express.Router();
const db = require('../config/db');

// 获取所有电影类型
router.get('/', async (req, res) => {
    try {
        const [types] = await db.query('SELECT * FROM movie_types ORDER BY name');
        res.json({ success: true, types });
    } catch (error) {
        console.error('Error fetching types:', error);
        res.status(500).json({ success: false, error: 'Internal server error' });
    }
});

// 创建新电影类型
router.post('/', async (req, res) => {
    try {
        const { name } = req.body;
        if (!name) {
            return res.status(400).json({ success: false, error: 'Name is required' });
        }

        const [result] = await db.query(
            'INSERT INTO movie_types (name) VALUES (?)',
            [name]
        );

        res.json({ 
            success: true, 
            type: { 
                id: result.insertId, 
                name
            } 
        });
    } catch (error) {
        console.error('Error creating type:', error);
        res.status(500).json({ success: false, error: 'Internal server error' });
    }
});

// 删除电影类型
router.delete('/:id', async (req, res) => {
    try {
        const [result] = await db.query('DELETE FROM movie_types WHERE id = ?', [req.params.id]);
        
        if (result.affectedRows === 0) {
            return res.status(404).json({ success: false, error: 'Type not found' });
        }

        res.json({ success: true, message: 'Type deleted successfully' });
    } catch (error) {
        console.error('Error deleting type:', error);
        res.status(500).json({ success: false, error: 'Internal server error' });
    }
});

// 获取指定类型的所有电影
router.get('/:id/movies', async (req, res) => {
    try {
        const [movies] = await db.query(`
            SELECT m.* 
            FROM movies m
            JOIN movie_type_relations mtr ON m.id = mtr.movie_id
            WHERE mtr.type_id = ?
        `, [req.params.id]);

        res.json({ success: true, movies });
    } catch (error) {
        console.error('Error fetching movies by type:', error);
        res.status(500).json({ success: false, error: 'Internal server error' });
    }
});

module.exports = router;
