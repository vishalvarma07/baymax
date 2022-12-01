var express = require('express')
let router = express.Router();
let pool = require('../resources');
let credentialCheck = require('../services/credentialCheck');

router.get('/', credentialCheck, (req, res) => {
    let details = {}
    pool.query('select * from patient', function(err, rows, fields){
        if(err){
            console.log(err);
            details.status = 'failed';
            res.status(404).json(details);
            return;
        }
        else{
            details.status = 'successful';
            details.data = rows;
            res.status(200).json(details);
            return;
        }
    })
})

router.post('/', credentialCheck, (req, res) =>{
    let userDetails = req.headers;
    let banDetails = req.body;
    let details = {};
    pool.query('update patient set ban = ? where uname = ?', [(banDetails.banstatus == 'ban'), banDetails.uname], function(err){
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
})

module.exports = router;