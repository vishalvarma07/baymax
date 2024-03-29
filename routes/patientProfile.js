const e = require('express');
let express = require('express');
let router = express.Router();
let pool = require('../resources');

let credentialCheck = require('../services/credentialCheck');

function validatePhoneNumber(input_str) {
    var re = /^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/;
  
    return re.test(input_str);
}

router.get('/', credentialCheck, (req, res) => {
    let userDetails = req.headers;
    let details = {}
    pool.query('select * from patient where uname = ?',[userDetails.uname], function(err, rows, fields){
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

router.post('/', credentialCheck, (req, res) => {
    let userHeaders = req.headers;
    let userDetails = req.body;
    let details = {}
    console.log(userDetails);
    console.log(validatePhoneNumber(userDetails.phno));
    if(validatePhoneNumber(userDetails.phno)){
        pool.query('update patient set dob = ?, fName = ?, lName = ?, phno = ?, gender = ?, height = ?, weight = ?, bloodType = ?, apartmentNo = ?, streetName = ?, state = ?, pincode = ? where uname = ?',[userDetails.dob, userDetails.fName, userDetails.lName, userDetails.phno, userDetails.gender, userDetails.height, userDetails.weight, userDetails.bloodType, userDetails.apartmentNo, userDetails.streetName, userDetails.state, userDetails.pincode, userHeaders.uname], function(err){
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
})

module.exports = router;