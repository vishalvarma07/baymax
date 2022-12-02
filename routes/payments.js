let express = require('express');
let router = express.Router();
let pool = require('../resources');

let credentialCheck = require('../services/credentialCheck');

router.get('/', credentialCheck, (req, res) => {
    let userDetails = req.headers;
    let payments = {}
    pool.query('select id from patient where uname = ?',[userDetails.uname], function(err, rows, fields){
        if(err){
            console.log(err);
            payments.status = 'failed';
            res.status(404).json(payments);
        }
        pool.query('select * from payment where patientId = ? and appointmentDate < now() order by appointmentDate asc',[rows[0].id], function(err, rows, fields){
            if(err){
                console.log(err);
                payments.status = 'failed';
                res.status(404).json(payments);
            }
            else{
                payments.status = 'successful';
                payments.data = rows;
                res.status(200).json(payments);
            }
        })
    })
})

router.put('/', credentialCheck, (req, res) => {
    let info = req.body;
    let details = {}
    pool.query('update payment set payStatus = 1, payDate = ? where id = ?',[info.payDate, info.paymentId], function(err){
        if(err){
            console.log(err);
            details.status = 'failed';
            res.status(404).json(details);
        }
        details.status = 'successful';
        res.status(200).json(details);
    })
})

router.post('/', credentialCheck, (req, res)=>{
    let medicineDetails = req.body;
    let details = {}
    for(let i=0;i<medicineDetails.meds.length;i++){
        pool.query('insert into medorder (medicineId, paymentId, medOrderedQuantity, medOrderDate) values (?, ?, ?, ?)',[medicineDetails.meds[i].id, medicineDetails.paymentId, medicineDetails.meds[i].quantity, medicineDetails.orderDate], function(err) {
            if(err){
                console.log(err);
                details.status = 'failed';
                res.status(404).json(details);
            }
        })
    }  
})

module.exports = router;
