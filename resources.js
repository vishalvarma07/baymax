const mysql = require('mysql2');
const pool = mysql.createPool({
    connectionLimit : 10,
    localAddress     : '127.0.0.1',
    user     : 'root',
    port : '3306',
    password : 'vishal123',
    database : 'baymax',
    debug    :  false
});

module.exports = pool;