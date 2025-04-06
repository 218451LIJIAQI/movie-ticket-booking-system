const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { logAction } = require('../utils/logger');
router.post('/comment/add', async (req, res) => {
    const { text, movie_id,uid,rating } = req.body;
    const connection = await db.getConnection();
    await connection.beginTransaction();
    let query = `
    insert into comment(text,movie_id,uid,rating) values (?,?,?,?)
    `
    await db.query(query,[text,movie_id,uid,rating]);
    await connection.commit();
    res.json({ 
        success: true,
        data: ""
    });
})
router.post('/comment/list' , async (req,res)=>{
    let query = `select c.id as id, m.title as title ,u.username as username,c.rating as rating ,c.text as text
     from comment as c inner join movies as m on c.movie_id =m.id inner join users as u on c.uid = u.id `;
     const [data] = await db.query(query);
     res.json({ 
        success: true,
        data: data
    });
})
router.post('/comment/del' , async (req,res)=>{
    const { id } = req.body;
    let query = `delete from comment where id = ?`
    db.query(query,[id]);
    res.json({ 
        success: true,
        data: ''
    });
})

// 获取预订列表（支持按用户名和预订ID过滤）
router.get('/filter', async (req, res) => {
    try {
        const { userName, bookingId } = req.query;
        let query = `
            SELECT 
                mb.id,
                u.id as userId,
                u.username as userName,
                mb.movie_id,
                m.title as movieTitle,
                m.show_time as showTime
            FROM movie_tickets mb
            JOIN users u ON mb.user_id = u.id
            JOIN movies m ON mb.movie_id = m.id
            WHERE 1=1
        `;
        const params = [];

        if (userName) {
            query += ` AND u.username LIKE ?`;
            params.push(`%${userName}%`);
        }
        if (bookingId) {
            query += ` AND mb.id = ?`;
            params.push(bookingId);
        }

        query += ' ORDER BY mb.id DESC';

        const [bookings] = await db.query(query, params);
        res.json({ 
            success: true,
            data: bookings
        });
    } catch (error) {
        console.error('Error filtering bookings:', error);
        res.status(500).json({ 
            success: false,
            error: 'Internal server error'
        });
    }
});

// 创建新预订
router.post('/', async (req, res) => {
    try {
        const { userId, movieId } = req.body;

        // 开启事务
        const connection = await db.getConnection();
        try {
            await connection.beginTransaction();

            // 检查电影是否存在且未过期
            const [movies] = await connection.query(`
                SELECT * FROM movies 
                WHERE id = ? AND show_time > NOW()
            `, [movieId]);

            if (movies.length === 0) {
                await connection.rollback();
                return res.status(400).json({
                    success: false,
                    error: 'Movie not found or show time has passed'
                });
            }

            // 创建预订记录
            await connection.query(`
                INSERT INTO movie_tickets (user_id, movie_id, booking_time)
                VALUES (?, ?, CURRENT_TIMESTAMP)
            `, [userId, movieId]);

            // 获取电影信息用于日志记录
            const [movieInfo] = await connection.query('SELECT title FROM movies WHERE id = ?', [movieId]);

            // 记录预订操作
            await logAction('CREATE_BOOKING', {
                bookingId: null,
                userId,
                userName: null,
                movieId,
                movieTitle: movieInfo[0]?.title,
                showTime: null,
                seatNumbers: null,
                totalPrice: null,
                createdAt: new Date()
            }, null);

            await connection.commit();
            res.json({ 
                success: true,
                message: 'Booking created successfully'
            });

        } catch (error) {
            await connection.rollback();
            console.error('Error creating booking:', error);
            res.status(500).json({ 
                success: false,
                error: 'Internal server error'
            });
        } finally {
            connection.release();
        }
    } catch (error) {
        console.error('Error creating booking:', error);
        res.status(500).json({ 
            success: false,
            error: 'Internal server error'
        });
    }
});

// 获取用户的所有预订
router.get('/user/:userId', async (req, res) => {
    try {
        const userId = req.params.userId;
        const [bookings] = await db.query(`
            SELECT 
                mb.id,
                mb.user_id,
                mb.movie_id,
                m.title as movie_title,
                m.image_url,
                m.price,
                m.duration,
                m.director,
                m.release_year,
                m.show_time
            FROM movie_tickets mb
            JOIN movies m ON mb.movie_id = m.id
            WHERE mb.user_id = ?
            ORDER BY mb.id DESC
        `, [userId]);

        res.json({ 
            success: true,
            data: bookings
        });
    } catch (error) {
        console.error('Error fetching user bookings:', error);
        res.status(500).json({ 
            success: false,
            error: 'Internal server error'
        });
    }
});

// 获取所有预定列表
router.get('/', async (req, res) => {
    try {
        const { userName, bookingId } = req.query;
        let query = `
            SELECT 
                mb.id,
                u.id as userId,
                u.username as userName,
                mb.movie_id,
                m.title as movieTitle,
                mb.seat_number,
                mb.purchase_time as showTime
            FROM movie_tickets mb
            JOIN users u ON mb.user_id = u.id
            JOIN movies m ON mb.movie_id = m.id
            WHERE 1=1
        `;
        const params = [];

        // 添加筛选条件
        if (userName) {
            query += ' AND u.username LIKE ?';
            params.push(`%${userName}%`);
        }
        if (bookingId) {
            query += ' AND mb.id = ?';
            params.push(bookingId);
        }

        query += ' ORDER BY mb.id DESC';

        const [bookings] = await db.query(query, params);

        // 处理座位号数据（从JSON字符串转换为数组）
        const processedBookings = bookings.map(booking => ({
            ...booking,
            seat_number: booking.seat_number ? JSON.parse(booking.seat_number) : []
        }));

        res.json({ 
            success: true,
            data: processedBookings
        });
    } catch (error) {
        console.error('Error fetching bookings:', error);
        res.status(500).json({ 
            success: false,
            error: 'Internal server error'
        });
    }
});

// 预订电影票
router.post('/tickets', async (req, res) => {
    try {
        const { movie_id, user_id, seat_number, screening_time, payment_method,t_time } = req.body;

        // 验证必要字段
        if (!movie_id || !user_id || !Array.isArray(seat_number) || seat_number.length === 0  || !payment_method) {
            return res.status(400).json({
                success: false,
                error: 'Missing required fields or invalid seat numbers'
            });
        }

        // 检查座位是否已被预订
        const [existingBookings] = await db.query(
            `SELECT JSON_EXTRACT(seat_number, '$[*]') as booked_seats 
             FROM movie_tickets 
             WHERE movie_id = ? 
             AND status != 'cancelled'
             AND JSON_OVERLAPS(seat_number, ?)`,
            [movie_id, screening_time, JSON.stringify(seat_number)]
        );

        if (existingBookings.length > 0) {
            const bookedSeats = existingBookings.map(booking => 
                JSON.parse(booking.booked_seats)
            ).flat();
            
            const conflictingSeats = seat_number.filter(seat => 
                bookedSeats.includes(seat)
            );

            return res.status(400).json({
                success: false,
                error: `Seats already booked: ${conflictingSeats.join(', ')}`
            });
        }

        // 获取电影价格
        const [movieResult] = await db.query(
            'SELECT price FROM movies WHERE id = ?',
            [movie_id]
        );

        if (movieResult.length === 0) {
            return res.status(404).json({
                success: false,
                error: 'Movie not found'
            });
        }

        const moviePrice = movieResult[0].price;
        const totalPrice = moviePrice * seat_number.length;

        // 开始事务
        await db.query('START TRANSACTION');

        try {
            // 创建票务记录
            const [result] = await db.query(
                `INSERT INTO movie_tickets 
                (movie_id, user_id, seat_number, paid_price, payment_method,t_time) 
                VALUES (?, ?, ?, ?, ?,?)`,
                [movie_id, user_id, JSON.stringify(seat_number), totalPrice, payment_method,t_time]
            );

            // 获取电影信息用于日志记录
            const [movieInfo] = await db.query('SELECT title FROM movies WHERE id = ?', [movie_id]);

            // 记录预订操作
            await logAction('CREATE_BOOKING', {
                bookingId: result.insertId,
                userId: user_id,
                userName: null,
                movieId: movie_id,
                movieTitle: movieInfo[0]?.title,
                showTime: screening_time,
                seatNumbers: seat_number,
                totalPrice,
                createdAt: new Date()
            }, null);

            // 提交事务
            await db.query('COMMIT');

            // 获取插入的票务记录
            const [tickets] = await db.query(
                `SELECT 
                    t.*, 
                    m.title as movie_title,
                    m.image,
                    m.duration,
                    m.director,
                    m.description,
                    m.releaseYear,
                    m.rating,
                    m.price as ticket_price,
                    m.show_time
                FROM movie_tickets t
                JOIN movies m ON t.movie_id = m.id
                WHERE t.id = ?`,
                [result.insertId]
            );

            const ticket = tickets[0];
            res.json({
                success: true,
                message: 'Tickets booked successfully',
                data: {
                    ticket: {
                        id: ticket.id,
                        movie_id: ticket.movie_id,
                        movie_title: ticket.movie_title,
                        image: ticket.image,
                        duration: ticket.duration,
                        genre: ticket.genre,
                        director: ticket.director,
                        description: ticket.description,
                        releaseYear: ticket.releaseYear,
                        rating: ticket.rating,
                        show_time: ticket.show_time,
                        seats: JSON.parse(ticket.seat_number),
                        screening_time: ticket.screening_time,
                        status: ticket.status,
                        payment_method: ticket.payment_method
                    },
                    total_price: totalPrice.toFixed(2)
                }
            });

        } catch (error) {
            // 如果出错，回滚事务
            await db.query('ROLLBACK');
            throw error;
        }

    } catch (error) {
        console.error('Error booking tickets:', error);
        res.status(500).json({
            success: false,
            error: 'Internal server error'
        });
    }
});

// 获取用户的电影票
router.get('/tickets/user/:userId', async (req, res) => {
    try {
        const userId = req.params.userId;
        
        const [tickets] = await db.query(
            `SELECT 
                t.*,
                m.title as movie_title,
                m.image_url,
                m.duration,
                m.show_time
            FROM movie_tickets t
            JOIN movies m ON t.movie_id = m.id
            WHERE t.user_id = ?
            ORDER BY t.purchase_time DESC`,
            [userId]
        );

        res.json({
            success: true,
            data: tickets
        });

    } catch (error) {
        console.error('Error fetching user tickets:', error);
        res.status(500).json({
            success: false,
            error: 'Internal server error'
        });
    }
});

// 获取用户预订历史（按电影分组座位）
router.get('/tickets/history/:userId', async (req, res) => {
    try {
        const userId = req.params.userId;
        
        const [bookings] = await db.query(`
            SELECT 
                t.id,
                t.movie_id,
                t.user_id,
                t.t_time,
                t.seat_number,
                t.paid_price,
                t.purchase_time,
                t.status,
                t.payment_method,
                m.title as movie_title,
                m.image,
                m.duration,
                m.director,
                m.description,
                m.releaseYear,
                m.rating,
                m.price as ticket_price,
                m.show_time,
                GROUP_CONCAT(DISTINCT mc.cast_member) as movie_cast,
                mr.imdb,
                mr.rottenTomatoes,
                mt.name as genre
            FROM movie_tickets t
            JOIN movies m ON t.movie_id = m.id
            inner join movie_types mt on m.type_id = mt.id
            LEFT JOIN movie_cast mc ON m.id = mc.movie_id
            LEFT JOIN movie_reviews mr ON m.id = mr.movie_id
            WHERE t.user_id = ?
            GROUP BY 
                t.id,
                t.movie_id,
                t.user_id,
                t.seat_number,
                t.paid_price,
                t.purchase_time,
                t.status,
                t.payment_method,
                m.title,
                m.image,
                m.duration,
                m.director,
                m.description,
                m.releaseYear,
                m.rating,
                m.price,
                m.show_time,
                mr.imdb,
                mr.rottenTomatoes
            ORDER BY t.purchase_time DESC
        `, [userId]);

        const formattedBookings = bookings.map(booking => ({
            movie: {
                id: booking.movie_id,
                title: booking.movie_title,
                image: booking.image,
                duration: booking.duration,
                genre: booking.genre,
                director: booking.director,
                description: booking.description,
                releaseYear: booking.releaseYear,
                rating: booking.rating,
                cast: booking.movie_cast ? booking.movie_cast.split(',') : [],
                ticket_price: booking.ticket_price,
                show_time: booking.show_time,
                reviews: {
                    imdb: booking.imdb || 'N/A',
                    rottenTomatoes: booking.rottenTomatoes || 'N/A'
                }
            },
            id: booking.id,
            user_id: booking.user_id,
            seats: JSON.parse(booking.seat_number),
            paid_price: booking.paid_price,
            purchase_time: booking.purchase_time,
            screening_time: booking.screening_time,
            status: booking.status,
            payment_method: booking.payment_method,
            t_time:booking.t_time
        }));

        res.json({
            success: true,
            data: formattedBookings
        });

    } catch (error) {
        console.error('Error fetching booking history:', error);
        res.status(500).json({
            success: false,
            error: 'Internal server error'
        });
    }
});

// 取消电影票
router.put('/tickets/:ticketId/cancel', async (req, res) => {
    try {
        const ticketId = req.params.ticketId;

        const [result] = await db.query(
            'UPDATE movie_tickets SET status = "cancelled" WHERE id = ? AND status = "pending"',
            [ticketId]
        );

        if (result.affectedRows === 0) {
            return res.status(400).json({
                success: false,
                error: 'Invalid ticket or ticket cannot be cancelled'
            });
        }

        // 获取电影信息用于日志记录
        const [movieInfo] = await db.query('SELECT title FROM movies WHERE id = ?', [ticketId]);

        // 记录预订操作
        await logAction('CANCEL_BOOKING', {
            bookingId: ticketId,
            userId: null,
            userName: null,
            movieId: null,
            movieTitle: movieInfo[0]?.title,
            showTime: null,
            seatNumbers: null,
            totalPrice: null,
            createdAt: new Date()
        }, null);

        res.json({
            success: true,
            message: 'Ticket cancelled successfully'
        });

    } catch (error) {
        console.error('Error cancelling ticket:', error);
        res.status(500).json({
            success: false,
            error: 'Internal server error'
        });
    }
});

// 取消电影票预订
router.put('/tickets/cancel', async (req, res) => {
    try {
        const { ticket_ids, user_id } = req.body;

        // 验证必要字段
        if (!ticket_ids || !Array.isArray(ticket_ids) || ticket_ids.length === 0 || !user_id) {
            return res.status(400).json({
                success: false,
                error: 'Missing required fields or invalid ticket IDs'
            });
        }

        // 开始事务
        await db.query('START TRANSACTION');

        try {
            // 验证票是否属于该用户
            const [tickets] = await db.query(`
                SELECT t.*, m.title as movie_title, m.show_time
                FROM movie_tickets t
                JOIN movies m ON t.movie_id = m.id
                WHERE t.id IN (?) AND t.user_id = ?
            `, [ticket_ids, user_id]);

            if (tickets.length === 0) {
                await db.query('ROLLBACK');
                return res.status(404).json({
                    success: false,
                    error: 'No valid tickets found for cancellation'
                });
            }

            if (tickets.length !== ticket_ids.length) {
                await db.query('ROLLBACK');
                return res.status(400).json({
                    success: false,
                    error: 'Some tickets are not available for cancellation'
                });
            }

            // 直接删除票务记录
            await db.query(`
                DELETE FROM movie_tickets 
                WHERE id IN (?) AND user_id = ?
            `, [ticket_ids, user_id]);

            // 记录预订操作
            await logAction('CANCEL_BOOKING', {
                bookingId: null,
                userId: user_id,
                userName: null,
                movieId: null,
                movieTitle: null,
                showTime: null,
                seatNumbers: null,
                totalPrice: null,
                createdAt: new Date()
            }, null);

            // 提交事务
            await db.query('COMMIT');

            // 返回已取消的票务信息
            res.json({
                success: true,
                message: 'Tickets cancelled successfully',
                data: {
                    cancelled_tickets: tickets.map(ticket => ({
                        id: ticket.id,
                        movie_title: ticket.movie_title,
                        show_time: ticket.show_time,
                        seats: JSON.parse(ticket.seat_number),
                        screening_time: ticket.screening_time,
                        refund_amount: ticket.paid_price
                    })),
                    total_refund: tickets.reduce((sum, ticket) => 
                        sum + parseFloat(ticket.paid_price), 0
                    ).toFixed(2)
                }
            });

        } catch (error) {
            // 如果出错，回滚事务
            await db.query('ROLLBACK');
            throw error;
        }

    } catch (error) {
        console.error('Error cancelling tickets:', error);
        res.status(500).json({
            success: false,
            error: 'Internal server error'
        });
    }
});

// 删除预订
router.delete('/:bookingId', async (req, res) => {
    try {
        const bookingId = req.params.bookingId;

        // 获取预订信息用于日志记录
        const [bookingInfo] = await db.query(`
            SELECT b.*, m.title as movie_title 
            FROM movie_tickets b 
            JOIN movies m ON b.movie_id = m.id 
            WHERE b.id = ?
        `, [bookingId]);

        // 开始事务
        await db.query('START TRANSACTION');

        // 删除相关的电影票
        const [result]  =  await db.query('DELETE FROM movie_tickets WHERE id = ?', [bookingId]);
        
        // 删除预订记录
      //  const [result] = await db.query('DELETE FROM bookings WHERE id = ?', [bookingId]);

        if (result.affectedRows === 0) {
            await db.query('ROLLBACK');
            res.status(404).json({ success: false, error: 'Booking not found' });
            return;
        }

        // 记录删除操作
        await logAction('DELETE_BOOKING', {
            bookingId,
            bookingDetails: bookingInfo[0],
            deletedAt: new Date()
        }, req.session?.username || bookingInfo[0]?.user_name);

        // 提交事务
        await db.query('COMMIT');

        res.json({ success: true, message: 'Booking deleted successfully' });
    } catch (error) {
        // 回滚事务
        await db.query('ROLLBACK');
        console.error('Error deleting booking:', error);
        res.status(500).json({ success: false, error: 'Internal server error' });
    }
});

module.exports = router;
