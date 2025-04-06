const mysql = require('mysql2');

const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '218451',
    database: 'pttdb',
});

// Convert pool to use promises
const promisePool = pool.promise();

module.exports = promisePool;
