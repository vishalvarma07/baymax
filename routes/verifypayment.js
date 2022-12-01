let express = require('express');
let router = express.Router();
let pool = require('../resources');
let credentialCheck = require('../services/credentialCheck');

router.get('/', credentialCheck, (req, res) =>{
    let adminDetails = req.headers;
    let details = {};
    pool.query('select * from payment where verifiedBy = NULL or payStatus = 0', function(err, rows, fields){
        if(err){
            console.log(err);
            details.status = 'failed';
            res.status(404).json(details);
            return;
        }
        else if(rows.length == 0){
            details.data = [];
            details.status = 'successful';
            res.status(200).json(details);
            return;
        }
        else{
            details.data = rows;
            for(let i=0;i<details.data.length;i++){
                pool.query('select fName from doctor where id = ?',[details.data[i].doctorId], function(err, rows, fields){
                    if(err){
                        console.log(err);
                        details.status = 'failed';
                        res.status(404).json(details);
                        return;
                    }
                    else{
                        details.data[i].dname = rows[0].fName;
                        pool.query('select fName from patient where id = ?',[details.data[i].patientID], function(err, rows, fields){
                            if(err){
                                console.log(err);
                                details.status = 'failed';
                                res.status(404).json(details);
                                return;
                            }
                            else{
                                details.data[i].pname = rows[0].fName;
                                pool.query('select * from med_details where paymentId = ?',[details.data[i].id], function(err, rows, fields){
                                    if(err){
                                        console.log(err);
                                        details.status = 'failed';
                                        res.status(404).json(details);
                                        return;
                                    }
                                    else{
                                        details.data[i].verified = true;
                                        details.data[i].meds = []
                                        for(let j = 0;j<rows.length;j++){
                                            details.data[i].meds.push({"id":rows[j].medicineId,"quantity":rows[j].medOrderedQuantity,"price":rows[0].mPrice});
                                            if(rows[j].verifiedBy == null){
                                                details.data[i].verified = false;
                                            }
                                        }
                                        if(i == details.data.length - 1){
                                            details.status = 'successful';
                                            res.status(200).json(details);
                                            return;
                                        }
                                    }
                                })
                            }
                        })
                    }
                })
            }
        }
    })
})


router.post('/', credentialCheck, (req, res) => {
    let paymentDetails = req.body;
    let userDetails = req.headers;
    let details = {}
    if(paymentDetails.type == 'payment'){
        console.log('ehllo')
        pool.query('select id from admin where uname = ?',[userDetails.uname], function(err, rows, fields){
            if(err){
                console.log(err);
                details.status = 'failed';
                res.status(404).json(details);
                return;
            }
            else{
                console.log(rows);
                pool.query('update payment set verifiedBy = ? where id = ?',[rows[0].id, paymentDetails.paymentId], function(err){
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
        })
    }
    else if(paymentDetails.type == 'meds'){
        pool.query('select id from admin where uname = ?,'[userDetails.uname], function(err, rows, fields){
            if(err){
                console.log(err);
                details.status = 'failed';
                res.status(404).json(details);
                return;
            }
            else{
                for(let i=0;i<paymentDetails.meds.length;i++){
                    pool.query('update medorder set verifiedBy = ? where paymentId = ? and medicineId = ?',[rows[0].id, paymentDetails.paymentId, paymentDetails.meds[i].id], function(err){
                        if(err){
                            console.log(err);
                            details.status = 'failed';
                            res.status(404).json(details);
                            return;
                        }
                        else{
                            pool.query('update medicine set quantity = quantity - ? where id = ?',[paymentDetails.meds[i].quantity, paymentDetails.meds[i].id], function(err){
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
                    })
                }
            }
        })
    }
})
module.exports = router;