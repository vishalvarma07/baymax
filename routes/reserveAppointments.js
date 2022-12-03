let express = require('express');
let router = express.Router();
let pool = require('../resources');
let credentialCheck = require('../services/credentialCheck');

router.get('/', credentialCheck, (req, res) => {
    let details = {}
    pool.query('select d.id, d.fName, s.specName, d.rating from doctor d, services s where d.specId = s.specId', function(err, rows, fields){
        if(err){
            console.log(err);
            details.status = 'failed';
            res.status(404).json(details);
            return;
        }
        else{
            details.data = rows;
            for(let i=0;i<rows.length;i++){
                pool.query('SELECT * FROM SLOT WHERE slotId NOT IN (SELECT pay.slotId FROM PAYMENT pay, DOCTOR d WHERE d.id=pay.doctorId and d.id = ? and date(pay.appointmentDate) = date(now()) AND slotId > hour(now()))', [details.data[i].id], function(err, rows, fields){
                    if(err){
                        console.log(err);
                        details.status = 'failed';
                        res.status(404).json(details);
                        return;
                    }
                    else{
                        details.data[i].today = rows.map(Object.values).flat(1);
                        pool.query('SELECT * FROM SLOT WHERE slotId NOT IN (SELECT pay.slotId FROM PAYMENT pay, DOCTOR d WHERE d.id=pay.doctorId and d.id=2 and date(pay.appointmentDate) = DATE_ADD(now(), INTERVAL 1 DAY))', [details.data[i].id], function(err, rows, fields){
                            if(err){
                                console.log(err);
                                details.status = 'failed';
                                res.status(404).json(details);
                                return;
                            }
                            else{
                                details.data[i].nextDay = rows.map(Object.values).flat(1);
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
        }
    })
})

router.post('/', credentialCheck, (req, res) => {
    let appointmentDetails = req.body;
    let details = {}
    pool.query('insert into')
})

module.exports = router;