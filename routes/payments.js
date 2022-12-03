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
                payments = rows;
                //console.log(payments);
                for(let i =0;i<payments.length;i++){
                    payments[i].meds = []
                    payments[i].verifiedBy = (payments[i].verifiedBy != null)
                    payments[i].payStatus = payments[i].payStatus == 1
                    pool.query('select fName from doctor where id = ?',[payments[i].doctorId], function(err, rows, fields){
                        if(err){
                            console.log(err);
                            details.status = 'failed';
                            res.status(404).json(payments);
                            return;
                        }
                        else{
                            payments[i].dName = rows[0].fName;
                            pool.query('select * from med_details where paymentId = ?',[payments[i].id], function(err, rows, fields){
                                if(err){
                                    console.log(err);
                                    details.status = 'failed';
                                    res.status(404).json(payments);
                                    return;
                                }
                                else{
                                    console.log(rows);
                                    for(let j = 0;j<rows.length;j++){
                                        payments[i].meds.push({"id":rows[j].medicineId, "name":rows[j].mName,"quantity":rows[j].medOrderedQuantity,"price":rows[0].mPrice});
                                        if(i == payments.length - 1 && j == rows.length - 1){
                                            payments.status = 'successful';
                                            res.status(200).json(payments);
                                            return;
                                        }
                                    }
                                    if(i == payments.length - 1){
                                        payments.status = 'successful';
                                        res.status(200).json(payments);
                                        return;
                                    }
                                }
                            })
                        }
                    })
                    //console.log(payments);
                }
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
