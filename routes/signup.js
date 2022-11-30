const { sign } = require('crypto');
let express = require('express');
let router = express.Router();
let pool = require('../resources');

router.post('/', (req, res) => {
    let details = {}
    let signupDetails = req.body;
    pool.query(`insert into patient (fName, lName, uname, pwd, dob) values (?, ?, ?, ?, ?)`,[signupDetails.fName, signupDetails.lName, signupDetails.uname, signupDetails.pwd, signupDetails.dob], function(err){
        if(err){
            console.log(err);
            details.status = 'failed';
            res.status(404).json(details);
            return;
        }
        details.status = 'successful';
        res.status(200).json(details);
    })
})

module.exports = router;