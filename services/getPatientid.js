let express = require('express');
let router = express.Router();
let pool = require('../resources');

module.exports = async (uname) => {
    if(typeof uname == 'undefined'){
        console.log('001')
        return;
    }
    console.log(uname+'hello');
    let details = {};
    try{
        let rows = await pool.query('select id from patient where uname like "edward%" ');
        console.log(rows);
        if(rows.length != 0){
            console.log('10');
            details.id = rows[0].id;
        }
        console.log(rows)
        return details;
    }
    catch(err){
        console.log(err);
        console.log('hey1')
        return details;
    }      
}