let express = require('express');
let router = express.Router();
let pool = require('../resources');

let credentialCheck = require('../services/credentialCheck');

router.post('/', credentialCheck, (req, res) => {
    let userDetails = req.headers;
    let userPassword = req.body;
    let details = {};
    pool.query(`select pwd from ${userDetails.user_type} where uname = ?`,[userDetails.uname], function(err, rows, fields){
        if(err){
            console.log(err);
            details.status = 'failed';
            res.status(404).json(details);
            return;
        }
        if(rows.length == 0){
            console.log(err);
            details.status = 'failed';
            res.status(401).json(details);
            return;
        }
        else{
            if(userPassword.old == rows[0].pwd){
                pool.query(`update ${userDetails.user_type} set pwd = ? where uname = ?`, [userPassword.new, userDetails.uname], function(err){
                    if(err){
                        console.log(err);
                        details.status = 'failed';
                        res.status(404).json(details);
                        return;
                    }
                    else{
                        details.status = 'successful';
                        res.status(200).json(details);
                        return;
                    }
                })
            }
            else{
                details.status = 'failed';
                res.status(401).json(details);
                return;
            }
        }
    })
})

module.exports = router;