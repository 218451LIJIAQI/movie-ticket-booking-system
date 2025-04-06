const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { logAction } = require('../utils/logger');

// 用户注册
router.post('/register', async (req, res) => {
    try {
        const { username, password, email } = req.body;

        // 验证输入
        if (!username || !password || !email) {
            return res.status(400).json({ error: 'Username, password and email are required' });
        }

        // 验证邮箱格式
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            return res.status(400).json({ error: 'Invalid email format' });
        }

        // 检查用户名是否已存在
        const [existingUsers] = await db.query(
            'SELECT id FROM users WHERE username = ? OR email = ?',
            [username, email]
        );

        if (existingUsers.length > 0) {
            return res.status(409).json({ error: 'Username or email already exists' });
        }

        // 插入新用户
        const [result] = await db.query(
            'INSERT INTO users (username, password, email) VALUES (?, ?, ?)',
            [username, password, email]
        );

        // 记录注册操作
        await logAction('USER_REGISTER', {
            userId: result.insertId,
            username,
            email,
            registrationTime: new Date()
        }, username);

        res.json({
            message: 'Registration successful',
            userId: result.insertId
        });
    } catch (error) {
        console.error('Error during registration:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// 用户登录
router.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;

        // 验证输入
        if (!username || !password) {
            return res.status(400).json({ error: 'Username and password are required' });
        }

        // 验证用户
        const [users] = await db.query(
            'SELECT * FROM users WHERE username = ? AND password = ?',
            [username, password]
        );

        if (users.length === 0) {
            return res.status(401).json({ error: 'Invalid username or password' });
        }

        const user = users[0];

        // 记录登录操作
        await logAction('USER_LOGIN', {
            userId: user.id,
            username: user.username,
            loginTime: new Date()
        }, user.username);

        res.json({
            message: 'Login successful',
            user: {
                id: user.id,
                username: user.username,
                email: user.email
            }
        });
    } catch (error) {
        console.error('Error during login:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

module.exports = router;
