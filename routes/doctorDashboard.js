let express = require('express');
let router = express.Router();
let pool = require('../resources');

const { route } = require('./dashboard');
let credentialCheck = require('../services/credentialCheck');
const getPatientid = require('../services/getPatientid');
const getDoctorid = require('../services/getDoctorid');

router.get('/', credentialCheck, (req, res) => {
    let dashboardDetails = {};
    console.log(req.headers.uname);
    pool.query('select * from patient where uname = ?',[req.headers.uname], function(err, rows, fields) {
        if(err){
            console.log(err);
            dashboardDetails.status = 'failed';
            res.status(400).json(dashboardDetails);
        }
        pool.query('select * from ongoingAppointments where id = ?',[rows[0].id], function(err, rows, fields) {
            if(err){
                console.log(err);
                dashboardDetails.status = 'failed';
                res.status(400).json(dashboardDetails);
            }
            if(rows.length == 0){
                dashboardDetails.status = 'successful';
                dashboardDetails.data = [];
            }
            else{
                dashboardDetails.status = 'successful';
                dashboardDetails.data = rows;
            }
            pool.query('select * from medicines where mQuantity > 0', function(err, rows, fields) {
                if(err){
                    dashboardDetails.status = 'failed';
                    res.status(404).json(dashboardDetails);
                }
                dashboardDetails.meds = rows;
                res.status(200).json(dashboardDetails);
            });
        })
    })
})

router.post('/', credentialCheck, (req, res) => {
    const info = req.body;
    //const uid = getDoctorid().id;
    let details = {}
    //console.log(uid);
    pool.query('select * from doctor where uname = ?',[req.headers.uname], function(err, rows, fields){
        if(err){
            console.log(err);
            details.status = 'failed';
            res.status(404).json(details);
        }
        pool.query('select * from ongoingAppointments where id = ?',[rows[0].id], function(err, rows, fields) {
            if(err){
                console.log(err);
                details.status = 'failed';
                res.status(401).json(details);
            }
            if(rows.length != 0){
                pool.query(`INSERT INTO PAYMENT (doctorId,appointmentId,appointmentDate,consultationFee,slotId,payStatus) VALUES (${rows[0].doctorId}, ${rows[0].appointmentId}, ${rows[0].price}, ${rows[0].slotId}, ${0})`, function(err) {
                    if(err){
                        console.log(err);
                        details.status = 'failed';
                        res.status(401).json(details);
                    }
                    pool.query('delete from reservation where appointmentId = ?',[rows[0].appointmentId], function(err) {
                        if(err){
                            console.log(err);
                            details.status = 'failed';
                            res.status(401).json(details);
                        }
                        pool.query('select id, appointmentId from payment where doctorId = ? and appointmentId = ?',[rows[0].doctorId, rows[0].appointmentId], function(err, rows, fields){
                            for(let i=0; i< info.meds.length;i++){
                                pool.query(`INSERT INTO MEDORDER (medicineId, paymentId, medOrderedQuantity, orderDate) VALUES (${info.meds[i].id},${rows[0].id}, ${info.meds[i].quantity}, ${rows[0].appointmentId})`, function(err){
                                    if(err){
                                        console.log(err);
                                        details.status = 'failed';
                                        res.status(401).json(details);
                                    }
                                    pool.query(`update medicines set mQuantity = mQuantity - ${info.meds[i].quantity} where id = ${info.meds[i].id}`, function(err) {
                                        if(err){
                                            console.log(err);
                                            details.status = 'failed';
                                            res.status(401).json(details);
                                        }
                                        details.status = 'successful';
                                        res.status(200).json(details);
                                    })
                                })
                            }
                        })
                    })
                })
            }
        })
    })
    
})

router.delete('/', credentialCheck, (req, res) => {
    let info = req.body;
    let details = {}
    pool.query('delete from table reservation where id = ?',[info.appointmentId], function(err) {
        if(err){
            console.log(err);
            details.status = 'failed';
            res.status(404).json(details);
        }
    })
})

module.exports = router;