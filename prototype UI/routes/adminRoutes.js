const express = require('express');
const router = express.Router();
const db = require('../config/db');



router.post('/membership/add', async (req, res) => {
    const {uid,level} = req.body;
    let query = `
        select * from membership where uid = ?
    `

    let [membershipdata] =  await db.query(query,[uid])
    if(membershipdata.length==0){
        query = `
        insert into membership(uid,level) values(?,?)
        `
        await db.query(query,[uid,level])
    }

     res.json({
        success: true,
    });
    })
router.post('/membership/get', async (req, res) => {
    const {uid} = req.body;
    let query = `
        select * from membership where uid = ?
    `
        const [restada] = await db.query(query,[uid])
        res.json({
        success: true,
        data: restada[0 ]
    });
    })
    router.post('/membership/list', async (req, res) => {
        let query = `
            select a.* ,b.username from membership as a  inner join users as b on a.uid = b.id
        `
            const [restada] = await db.query(query)
            res.json({
            success: true,
            data: restada
        });
        })
router.post('/membership/update', async (req, res) => {
    const {id,level} = req.body;
    let query = `
        update membership set level = ? where id = ?
    `
        const [restada] = await db.query(query,[level,id])
        res.json({
        success: true,
    });
    })
router.post('/seats', async (req, res) => {
    let query = `
        select * from seat
    `
     const [restada] = await db.query(query)
     res.json({
        success: true,
        data: restada
    });
    })
    router.post('/seats/status', async (req, res) => {
        const {id,status} = req.body;
        let query = `
            update seat set status = ? where id = ?
        `
        db.query(query,[status,id])
        res.json({
            success: true
        })
    })
// 管理员登录
router.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;

        // 验证输入
        if (!username || !password) {
            return res.status(400).json({ error: 'Username and password are required' });
        }

        // 验证管理员
        const [admins] = await db.query(
            'SELECT * FROM admins WHERE username = ? AND password = ?',
            [username, password]
        );

        if (admins.length === 0) {
            return res.status(401).json({ error: 'Invalid username or password' });
        }

        // 生成一个简单的 token（实际应用中应该使用 JWT）
        const token = Buffer.from(`${username}:${Date.now()}`).toString('base64');

        res.json({
            success: true,
            admin: {
                id: admins[0].id,
                username: admins[0].username
            },
            token: token
        });
    } catch (error) {
        console.error('Error during admin login:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// 管理员退出
router.post('/logout', async (req, res) => {
    try {
        // 在实际应用中，这里应该处理 token 失效等逻辑
        res.json({ success: true });
    } catch (error) {
        console.error('Error during admin logout:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// 获取所有用户
router.get('/users', async (req, res) => {
    try {
        const [users] = await db.query('SELECT id, username, email FROM users');
        
        // 记录日志
        await db.query(
            'INSERT INTO logs (action, username) VALUES (?, ?)',
            ['GET_USERS', req.headers.username]
        );
        
        res.json(users);
    } catch (error) {
        console.error('Error fetching users:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// 搜索用户
router.get('/users/search', async (req, res) => {
    try {
        const query = req.query.query;
        const [users] = await db.query(
            'SELECT id, username, email FROM users WHERE username LIKE ? OR email LIKE ?',
            [`%${query}%`, `%${query}%`]
        );
        
        // 记录日志
        await db.query(
            'INSERT INTO logs (action, username) VALUES (?, ?)',
            ['SEARCH_USERS', req.headers.username]
        );
        
        res.json(users);
    } catch (error) {
        console.error('Error searching users:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// 获取所有预订
router.get('/bookings', async (req, res) => {
    try {
        const [bookings] = await db.query('SELECT * FROM bookings');
        
        // 记录日志
        await db.query(
            'INSERT INTO logs (action, username) VALUES (?, ?)',
            ['GET_BOOKINGS', req.headers.username]
        );
        
        res.json(bookings);
    } catch (error) {
        console.error('Error fetching bookings:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// 过滤预订
router.get('/bookings/filter', async (req, res) => {
    try {
        const { userId, bookingId } = req.query;
        let query = 'SELECT * FROM bookings WHERE 1=1';
        const params = [];
        
        if (userId) {
            params.push(userId);
            query += ` AND user_id = ?`;
        }
        if (bookingId) {
            params.push(bookingId);
            query += ` AND id = ?`;
        }
        
        const [bookings] = await db.query(query, params);
        
        // 记录日志
        await db.query(
            'INSERT INTO logs (action, username) VALUES (?, ?)',
            ['FILTER_BOOKINGS', req.headers.username]
        );
        
        res.json(bookings);
    } catch (error) {
        console.error('Error filtering bookings:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// 修改用户信息
router.put('/users/:userId', async (req, res) => {
    try {
        const userId = req.params.userId;
        const { username, email } = req.body;

        // 验证输入
        if (!username || !email) {
            return res.status(400).json({ error: 'Username and email are required' });
        }

        // 更新用户信息
        const [result] = await db.query(
            'UPDATE users SET username = ?, email = ? WHERE id = ?',
            [username, email, userId]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'User not found' });
        }

        res.json({ 
            success: true,
            message: 'User updated successfully' 
        });
    } catch (error) {
        console.error('Error updating user:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// 删除用户
router.delete('/users/:userId', async (req, res) => {
    try {
        const userId = req.params.userId;

        // 删除用户
        const [result] = await db.query(
            'DELETE FROM users WHERE id = ?',
            [userId]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'User not found' });
        }

        res.json({ 
            success: true,
            message: 'User deleted successfully' 
        });
    } catch (error) {
        console.error('Error deleting user:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// 获取日志列表（分页）
router.get('/logs', async (req, res) => {
    try {
        const page = parseInt(req.query.page) || 1;
        const pageSize = parseInt(req.query.pageSize) || 10;
        const offset = (page - 1) * pageSize;

        // 获取总记录数
        const [totalResult] = await db.query('SELECT COUNT(*) as total FROM logs');
        const total = totalResult[0].total;

        // 获取分页数据
        const [logs] = await db.query(`
            SELECT id, action, username, created_at
            FROM logs
            ORDER BY created_at DESC
            LIMIT ? OFFSET ?
        `, [pageSize, offset]);

        console.log('Logs pagination:', { page, pageSize, total, totalPages: Math.ceil(total / pageSize) });

        res.json({
            success: true,
            logs,
            pagination: {
                total,
                page,
                pageSize,
                totalPages: Math.ceil(total / pageSize)
            }
        });
    } catch (error) {
        console.error('Error fetching logs:', error);
        res.status(500).json({ success: false, error: error.message });
    }
});

module.exports = router;
