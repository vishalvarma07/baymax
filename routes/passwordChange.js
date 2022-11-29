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
        }
    })
})

module.exports = router;