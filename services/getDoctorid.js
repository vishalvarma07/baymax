let express = require('express');
let router = express.Router();
let pool = require('../resources');

module.exports = async(uname) => {
    if(typeof uname == 'undefined'){
        return;
    }
    let details = {}
    pool.query('select id from doctor where uname = ?',[uname], function(err, rows, fields){
        if(rows.length != 0){
            details.id = rows[0].id;
        }
    })
    return details;
}