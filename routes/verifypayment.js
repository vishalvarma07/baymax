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
        }
        else if(rows.length == 0){
            details.data = [];
            details.status = 'successful';
            res.status(200).json(details);
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

module.exports = router;