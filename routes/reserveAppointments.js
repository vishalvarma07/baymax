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
                pool.query('SELECT * FROM SLOT WHERE slotId NOT IN (SELECT r.slotId FROM reservations r, payment pay, DOCTOR d WHERE d.id=r.doctorId and d.id=2 and date(r.appointmentDate) = date(now()) AND r.slotId > hour(now())) and slotId > hour(now());', [details.data[i].id], function(err, rows, fields){
                    if(err){
                        console.log(err);
                        details.status = 'failed';
                        res.status(404).json(details);
                        return;
                    }
                    else{
                        details.data[i].today = rows.map(Object.values).flat(1);
                        pool.query('SELECT * FROM SLOT WHERE slotId NOT IN (SELECT r.slotId FROM PAYMENT pay, reservations r, DOCTOR d WHERE d.id=r.doctorId and d.id=2 and date(r.appointmentDate) = DATE_ADD(now(), INTERVAL 1 DAY));', [details.data[i].id], function(err, rows, fields){
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
    let userDetails = req.headers;
    let details = {}
    pool.query('select id from patient where uname = ?',[userDetails.uname], function(err, rows, fields) {
        if(err){
            console.log(err);
            details.status = 'failed';
            res.status(404).json(details);
            return;
        }
        else{
            pool.query('insert into reservations (patientId, doctorId, slotId, reservationDesc, appointmentDate) values (?, ?, ?, ?, ?)',[rows[0].id, appointmentDetails.doctorId, appointmentDetails.slotId, appointmentDetails.reservationDesc, appointmentDetails.appointmentDate], function(err){
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
})

module.exports = router;