let express = require('express');
let router = express.Router();
let pool = require('../resources');

module.exports = (req, res, next) => {
    const loginDetails = req.headers;
    console.log(req.headers);
    let details = {}
    pool.query(`select * from ${loginDetails.user_type} where uname = ?`, [loginDetails.uname], function(error, rows, fields){
        if(error){
            console.log(error);
            details.status = 'failed'
            res.status(404).json(details);
        }
        if(rows.length == 0){
            details.status = 'failed';
            res.status(401).json(details);
        }
        else{
            if(rows[0].pwd == loginDetails.pwd){
                console.log("credentials check successful");
                next();
            }
            else{
                details.status = 'failed';
                res.status(401).json(details);
            }
        }
    })
}