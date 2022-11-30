let express = require('express');
let router = express.Router();
let pool = require('../resources');
let credentialCheck = require('../services/credentialCheck');

router.get('/', credentialCheck, (req, res) =>{
    let adminDetails = req.headers;
    let details = {};
    pool.query('select * from payments where verifiedBy = NULL or payStatus = 0', function(err, rows, fields){
        if(err){
            console.log(err);
            
        }
    })
})

module.exports = router;