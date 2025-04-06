const express = require('express');
const router = express.Router();
const db = require('../config/db.js');
const { logAction } = require('../utils/logger');

// 创建数据库连接池

// 获取所有电影列表（包含完整信息）
router.get('/', async (req, res) => {
    try {
        const [movies] = await db.query(`
            SELECT m.*, 
                   mt.name as type_name,
                   GROUP_CONCAT(DISTINCT mc.cast_member) as cast_members,
                   MAX(mr.imdb) as imdb,
                   MAX(mr.rottenTomatoes) as rottenTomatoes,
                   GROUP_CONCAT(DISTINCT mh.highlight) as highlights
            FROM movies m
            LEFT JOIN movie_types mt ON m.type_id = mt.id
            LEFT JOIN movie_cast mc ON m.id = mc.movie_id
            LEFT JOIN movie_reviews mr ON m.id = mr.movie_id
            LEFT JOIN movie_highlights mh ON m.id = mh.movie_id
            GROUP BY m.id, m.title, m.director, m.duration, 
                     m.price, m.releaseYear, m.rating, m.description, 
                     m.image, m.created_at, m.updated_at, mt.name
            ORDER BY m.id DESC
        `);

        // 处理数据格式
        const formattedMovies = movies.map(movie => ({
            ...movie,
            type: {
                id: movie.type_id,
                name: movie.type_name
            },
            cast: movie.cast_members ? movie.cast_members.split(',') : [],
            reviews: {
                imdb: movie.imdb,
                rottenTomatoes: movie.rottenTomatoes
            },
            highlights: movie.highlights ? movie.highlights.split(',') : []
        }));

        res.json({ success: true, data: formattedMovies });
    } catch (error) {
        console.error('Error fetching movies:', error);
        res.status(500).json({ success: false, message: '获取电影列表失败' });
    }
});

// 获取单个电影详情
router.get('/:id', async (req, res) => {
    try {
        // 获取电影基本信息
        const [movies] = await db.query(`
            SELECT m.*, 
                   mt.name as type_name,
                   GROUP_CONCAT(DISTINCT mc.cast_member) as cast_members,
                   MAX(mr.imdb) as imdb,
                   MAX(mr.rottenTomatoes) as rottenTomatoes,
                   GROUP_CONCAT(DISTINCT mh.highlight) as highlights
            FROM movies m
            LEFT JOIN movie_types mt ON m.type_id = mt.id
            LEFT JOIN movie_cast mc ON m.id = mc.movie_id
            LEFT JOIN movie_reviews mr ON m.id = mr.movie_id
            LEFT JOIN movie_highlights mh ON m.id = mh.movie_id
            WHERE m.id = ?
            GROUP BY m.id, m.title, m.director, m.duration, 
                     m.price, m.releaseYear, m.rating, m.description, 
                     m.image, m.created_at, m.updated_at, mt.name
        `, [req.params.id]);

        if (movies.length === 0) {
            return res.status(404).json({ 
                success: false, 
                message: '电影不存在'
            });
        }

        // 处理数据格式
        const movie = {
            ...movies[0],
            type: {
                id: movies[0].type_id,
                name: movies[0].type_name
            },
            cast: movies[0].cast_members ? movies[0].cast_members.split(',') : [],
            reviews: {
                imdb: movies[0].imdb,
                rottenTomatoes: movies[0].rottenTomatoes
            },
            highlights: movies[0].highlights ? movies[0].highlights.split(',') : []
        };

        res.json({ success: true, data: movie });
    } catch (error) {
        console.error('Error fetching movie:', error);
        res.status(500).json({ success: false, message: '获取电影详情失败' });
    }
});

// 搜索电影
router.get('/search', async (req, res) => {
    const { query } = req.query;
    try {
        const [movies] = await db.query(`
            SELECT m.*, 
                   GROUP_CONCAT(DISTINCT mc.cast_member) as cast_members,
                   MAX(mr.imdb) as imdb,
                   MAX(mr.rottenTomatoes) as rottenTomatoes,
                   GROUP_CONCAT(DISTINCT mh.highlight) as highlights
            FROM movies m
            LEFT JOIN movie_cast mc ON m.id = mc.movie_id
            LEFT JOIN movie_reviews mr ON m.id = mr.movie_id
            LEFT JOIN movie_highlights mh ON m.id = mh.movie_id
            WHERE m.title LIKE ? OR m.director LIKE ? 
            GROUP BY m.id, m.title,, m.director, m.duration, 
                     m.price, m.releaseYear, m.rating, m.description, 
                     m.image, m.created_at, m.updated_at
        `, [`%${query}%`, `%${query}%`, `%${query}%`]);

        const formattedMovies = movies.map(movie => ({
            ...movie,
            cast: movie.cast_members ? movie.cast_members.split(',') : [],
            reviews: {
                imdb: movie.imdb,
                rottenTomatoes: movie.rottenTomatoes
            },
            highlights: movie.highlights ? movie.highlights.split(',') : []
        }));

        res.json({ success: true, data: formattedMovies });
    } catch (error) {
        console.error('Error searching movies:', error);
        res.status(500).json({ success: false, message: '搜索电影失败' });
    }
});

// 按年份筛选电影
router.get('/year/:year', async (req, res) => {
    try {
        const [movies] = await db.query(`
            SELECT m.*, 
                   GROUP_CONCAT(DISTINCT mc.cast_member) as cast_members,
                   MAX(mr.imdb) as imdb,
                   MAX(mr.rottenTomatoes) as rottenTomatoes,
                   GROUP_CONCAT(DISTINCT mh.highlight) as highlights
            FROM movies m
            LEFT JOIN movie_cast mc ON m.id = mc.movie_id
            LEFT JOIN movie_reviews mr ON m.id = mr.movie_id
            LEFT JOIN movie_highlights mh ON m.id = mh.movie_id
            WHERE m.releaseYear = ?
            GROUP BY m.id, m.title, m.director, m.duration, 
                     m.price, m.releaseYear, m.rating, m.description, 
                     m.image, m.created_at, m.updated_at
        `, [req.params.year]);

        const formattedMovies = movies.map(movie => ({
            ...movie,
            cast: movie.cast_members ? movie.cast_members.split(',') : [],
            reviews: {
                imdb: movie.imdb,
                rottenTomatoes: movie.rottenTomatoes
            },
            highlights: movie.highlights ? movie.highlights.split(',') : []
        }));

        res.json({ success: true, data: formattedMovies });
    } catch (error) {
        console.error('Error filtering movies by year:', error);
        res.status(500).json({ success: false, message: '按年份筛选电影失败' });
    }
});

// 删除电影
router.delete('/:id', async (req, res) => {
    try {
        const movieId = req.params.id;
        
        // 获取电影信息用于日志记录
        const [movie] = await db.query('SELECT * FROM movies WHERE id = ?', [movieId]);
        
        const [result] = await db.query('DELETE FROM movies WHERE id = ?', [movieId]);
        
        if (result.affectedRows === 0) {
            res.status(404).json({ success: false, message: '电影不存在' });
            return;
        }
        
        // 记录删除操作
        await logAction('DELETE_MOVIE', {
            movieId,
            movieTitle: movie[0]?.title,
            deletedAt: new Date()
        }, req.session?.username);

        res.json({ success: true, message: '电影删除成功' });
    } catch (error) {
        console.error('Error deleting movie:', error);
        res.status(500).json({ success: false, message: '删除电影失败' });
    }
});

// creat new movie
router.post('/', async (req, res) => {
    try {
        const {
            title,
            director,
            duration,
            price,
            release_year,
            rating,
            description,
            image_url,
            type_id
        } = req.body;

        const [result] = await db.query(
            `INSERT INTO movies (
                title, director, duration, price, 
                releaseYear, rating, description, image, type_id
            ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [title, director, duration, price, release_year, rating, description, image_url, type_id]
        );

        // Log Add Operation
        await logAction('ADD_MOVIE', {
            movieId: result.insertId,
            movieTitle: title,
            movieDetails: req.body,
            createdAt: new Date()
        }, req.session?.username);

        res.json({ 
            success: true, 
            message: '电影添加成功',
            data: { id: result.insertId }
        });
    } catch (error) {
        console.error('Error adding movie:', error);
        res.status(500).json({ success: false, message: '添加电影失败' });
    }
});

// 修改电影
router.put('/:id', async (req, res) => {
    try {
        const movieId = req.params.id;
        const {
            title,
            director,
            duration,
            price,
            release_year,
            rating,
            description,
            image_url,
            type_id
        } = req.body;

        // 获取更新前的电影信息用于日志记录
        const [oldMovie] = await db.query('SELECT * FROM movies WHERE id = ?', [movieId]);

        const [result] = await db.query(
            `UPDATE movies SET 
                title = ?, 
                director = ?,
                duration = ?,
                price = ?,
                releaseYear = ?,
                rating = ?,
                description = ?,
                image = ?,
                type_id = ?
            WHERE id = ?`,
            [title, director, duration, price, release_year, rating, description, image_url, type_id, movieId]
        );

        if (result.affectedRows === 0) {
            res.status(404).json({ success: false, message: '电影不存在' });
            return;
        }

        // 记录更新操作
        await logAction('UPDATE_MOVIE', {
            movieId,
            movieTitle: title,
            oldData: oldMovie[0],
            newData: req.body,
            updatedAt: new Date()
        }, req.session?.username);

        res.json({ success: true, message: '电影更新成功' });
    } catch (error) {
        console.error('Error updating movie:', error);
        res.status(500).json({ success: false, message: '更新电影失败' });
    }
});

// 添加用户评分
router.post('/ratings', async (req, res) => {
    try {
        const { user_id, movie_id, rating, comment } = req.body;

        // 验证必要字段
        if (!user_id || !movie_id || rating === undefined || rating < 0 || rating > 5) {
            return res.status(400).json({
                success: false,
                error: 'Invalid rating data. Rating must be between 0 and 5.'
            });
        }

        // 验证用户是否看过这部电影（有购票记录）
        const [tickets] = await db.query(
            'SELECT id FROM movie_tickets WHERE user_id = ? AND movie_id = ?',
            [user_id, movie_id]
        );

        if (tickets.length === 0) {
            return res.status(403).json({
                success: false,
                error: 'You can only rate movies you have booked tickets for.'
            });
        }

        // 检查是否已经评分过
        const [existingRating] = await db.query(
            'SELECT id FROM user_ratings WHERE user_id = ? AND movie_id = ?',
            [user_id, movie_id]
        );

        if (existingRating.length > 0) {
            // 更新现有评分
            await db.query(
                'UPDATE user_ratings SET rating = ?, comment = ? WHERE user_id = ? AND movie_id = ?',
                [rating, comment || null, user_id, movie_id]
            );
        } else {
            // 添加新评分
            await db.query(
                'INSERT INTO user_ratings (user_id, movie_id, rating, comment) VALUES (?, ?, ?, ?)',
                [user_id, movie_id, rating, comment || null]
            );
        }

        // 更新电影的平均评分
        await updateMovieAverageRating(movie_id);

        res.json({
            success: true,
            message: existingRating.length > 0 ? 'Rating updated successfully' : 'Rating added successfully'
        });

    } catch (error) {
        console.error('Error adding rating:', error);
        res.status(500).json({
            success: false,
            error: 'Internal server error'
        });
    }
});

// 获取用户对电影的评分
router.get('/ratings/:userId/:movieId', async (req, res) => {
    try {
        const { userId, movieId } = req.params;

        const [ratings] = await db.query(
            'SELECT rating, comment, created_at FROM user_ratings WHERE user_id = ? AND movie_id = ?',
            [userId, movieId]
        );

        res.json({
            success: true,
            data: ratings[0] || null
        });

    } catch (error) {
        console.error('Error fetching rating:', error);
        res.status(500).json({
            success: false,
            error: 'Internal server error'
        });
    }
});

// 获取电影的所有评分
router.get('/ratings/:movieId', async (req, res) => {
    try {
        const { movieId } = req.params;
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 10;
        const offset = (page - 1) * limit;

        // 获取总评分数
        const [totalCount] = await db.query(
            'SELECT COUNT(*) as count FROM user_ratings WHERE movie_id = ?',
            [movieId]
        );

        // 获取评分列表
        const [ratings] = await db.query(`
            SELECT 
                ur.rating,
                ur.comment,
                ur.created_at,
                u.username
            FROM user_ratings ur
            JOIN users u ON ur.user_id = u.id
            WHERE ur.movie_id = ?
            ORDER BY ur.created_at DESC
            LIMIT ? OFFSET ?
        `, [movieId, limit, offset]);

        // 获取评分统计
        const [stats] = await db.query(`
            SELECT 
                COUNT(*) as total_ratings,
                AVG(rating) as average_rating,
                COUNT(CASE WHEN rating = 5 THEN 1 END) as five_star,
                COUNT(CASE WHEN rating = 4 THEN 1 END) as four_star,
                COUNT(CASE WHEN rating = 3 THEN 1 END) as three_star,
                COUNT(CASE WHEN rating = 2 THEN 1 END) as two_star,
                COUNT(CASE WHEN rating = 1 THEN 1 END) as one_star
            FROM user_ratings
            WHERE movie_id = ?
        `, [movieId]);

        res.json({
            success: true,
            data: {
                ratings,
                stats: stats[0],
                pagination: {
                    current_page: page,
                    total_pages: Math.ceil(totalCount[0].count / limit),
                    total_items: totalCount[0].count,
                    items_per_page: limit
                }
            }
        });

    } catch (error) {
        console.error('Error fetching ratings:', error);
        res.status(500).json({
            success: false,
            error: 'Internal server error'
        });
    }
});

// 辅助函数：更新电影的平均评分
async function updateMovieAverageRating(movieId) {
    try {
        const [ratings] = await db.query(`
            SELECT 
                COUNT(*) as total_ratings,
                AVG(rating) as average_rating
            FROM user_ratings
            WHERE movie_id = ?
        `, [movieId]);

        const { total_ratings, average_rating } = ratings[0];

        await db.query(
            'UPDATE movies SET rating = ? WHERE id = ?',
            [average_rating || 0, movieId]
        );

        return true;
    } catch (error) {
        console.error('Error updating movie average rating:', error);
        return false;
    }
}

module.exports = router;
