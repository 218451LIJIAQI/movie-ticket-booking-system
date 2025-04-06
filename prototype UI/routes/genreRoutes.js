const express = require('express');
const router = express.Router();
const db = require('../config/db');

// 获取所有电影类型
router.get('/', async (req, res) => {
    try {
        const [genres] = await db.query('SELECT * FROM movie_genres ORDER BY name');
        res.json({ success: true, genres });
    } catch (error) {
        console.error('Error fetching genres:', error);
        res.status(500).json({ success: false, error: 'Internal server error' });
    }
});

// 获取单个电影类型
router.get('/:id', async (req, res) => {
    try {
        const [genres] = await db.query('SELECT * FROM movie_genres WHERE id = ?', [req.params.id]);
        if (genres.length === 0) {
            return res.status(404).json({ success: false, error: 'Genre not found' });
        }
        res.json({ success: true, genre: genres[0] });
    } catch (error) {
        console.error('Error fetching genre:', error);
        res.status(500).json({ success: false, error: 'Internal server error' });
    }
});

// 创建新电影类型
router.post('/', async (req, res) => {
    try {
        const { name, description } = req.body;
        if (!name) {
            return res.status(400).json({ success: false, error: 'Name is required' });
        }

        const [result] = await db.query(
            'INSERT INTO movie_genres (name, description) VALUES (?, ?)',
            [name, description]
        );

        res.json({ 
            success: true, 
            genre: { 
                id: result.insertId, 
                name, 
                description 
            } 
        });
    } catch (error) {
        console.error('Error creating genre:', error);
        res.status(500).json({ success: false, error: 'Internal server error' });
    }
});

// 更新电影类型
router.put('/:id', async (req, res) => {
    try {
        const { name, description } = req.body;
        if (!name) {
            return res.status(400).json({ success: false, error: 'Name is required' });
        }

        const [result] = await db.query(
            'UPDATE movie_genres SET name = ?, description = ? WHERE id = ?',
            [name, description, req.params.id]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ success: false, error: 'Genre not found' });
        }

        res.json({ success: true, message: 'Genre updated successfully' });
    } catch (error) {
        console.error('Error updating genre:', error);
        res.status(500).json({ success: false, error: 'Internal server error' });
    }
});

// 删除电影类型
router.delete('/:id', async (req, res) => {
    try {
        const [result] = await db.query('DELETE FROM movie_genres WHERE id = ?', [req.params.id]);
        
        if (result.affectedRows === 0) {
            return res.status(404).json({ success: false, error: 'Genre not found' });
        }

        res.json({ success: true, message: 'Genre deleted successfully' });
    } catch (error) {
        console.error('Error deleting genre:', error);
        res.status(500).json({ success: false, error: 'Internal server error' });
    }
});

// 获取指定电影类型的所有电影
router.get('/:id/movies', async (req, res) => {
    try {
        const [movies] = await db.query(`
            SELECT m.* 
            FROM movies m
            JOIN movie_genre_relations mgr ON m.id = mgr.movie_id
            WHERE mgr.genre_id = ?
        `, [req.params.id]);

        res.json({ success: true, movies });
    } catch (error) {
        console.error('Error fetching movies by genre:', error);
        res.status(500).json({ success: false, error: 'Internal server error' });
    }
});

module.exports = router;
