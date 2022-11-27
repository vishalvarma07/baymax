let express = require('express');
let router = express.Router();
let pool = require('../resources');

module.exports = (req, res, next) => {
    const loginDetails = req.headers;
    let details = {}
    pool.query('select * from patient where uname = ?', [loginDetails.uname], function(error, rows, fields){
        if(error){
            console.log(err);
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