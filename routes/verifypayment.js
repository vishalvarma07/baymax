let express = require('express');
let router = express.Router();
let pool = require('../resources');
let credentialCheck = require('../services/credentialCheck');

router.get('/', credentialCheck, (req, res) =>{
    let adminDetails = req.headers;
    let details = {};
    pool.query('select id from admin where email = ?',[adminDetails.uname], function(err, rows, fields){
        if(err){
            console.log(err);
            details.status = 'failed';
            res.status(404).json(details);
        }
        
    })

})

module.exports = router;