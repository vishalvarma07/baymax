var express = require('express')
let router = express.Router();
let pool = require('../resources');
let credentialCheck = require('../services/credentialCheck');

router.get('/', credentialCheck, (req, res) => {
    let details = {}
    pool.query('select * from patients', function(err, rows, fields){
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

module.exports = router;