let express = require('express');
let router = express.Router();
let pool = require('../resources');

let credentialCheck = require('../services/credentialCheck');

router.get('/', credentialCheck, (req, res) => {
    let dashboardDetails = {};
    pool.query('select * from doctor where uname = ?',[req.headers.uname], function(err, rows, fields) {
        if(err){
            console.log(err);
            dashboardDetails.status = 'failed';
            res.status(400).json(dashboardDetails);
            return;
        }
        dashboardDetails.dName = rows[0].fName,
        dashboardDetails.rating = rows[0].rating;
        let doctorId = rows[0].id;
        dashboardDetails.ongoing = []
        dashboardDetails.meds = []
        pool.query('select * from ongoingAppointments where doctorId = ?',[doctorId], function(err, rows, fields) {
            if(err){
                console.log(err);
                dashboardDetails.status = 'failed';
                res.status(404).json(dashboardDetails);
                return;
            }
            else if(rows.length == 0){
                dashboardDetails.status = 'successful';
                dashboardDetails.ongoing = [];
            }
            else{
                dashboardDetails.status = 'successful';
                dashboardDetails.ongoing = rows;
            }
            pool.query('select * from medicines where mQuantity > 0', function(err, rows, fields) {
                if(err){
                    dashboardDetails.status = 'failed';
                    res.status(404).json(dashboardDetails);
                    return;
                }
                else{
                    dashboardDetails.meds = rows;
                    pool.query('select * from upcomingappointments where doctorId = ?',[doctorId], function(err, rows, fields){
                        if(err){
                            dashboardDetails.status = 'failed';
                            res.status(404).json(dashboardDetails);
                            return;
                        }
                        else{
                            dashboardDetails.upcoming = rows;
                            dashboardDetails.status = 'successful';
                            res.status(200).json(dashboardDetails);
                        }
                    })
                }
            });
        })
    })
})

router.post('/', credentialCheck, (req, res) => {
    const info = (req.body);
    info.meds = JSON.parse(info.meds);
    let details = {}
    pool.query('select * from doctor where uname = ?',[req.headers.uname], function(err, rows, fields){
        if(err){
            console.log(err);
            details.status = 'failed';
            res.status(404).json(details);
            return;
        }
        else{
            pool.query('select * from ongoingAppointments where doctorId = ?',[rows[0].id], function(err, rows, fields) {
                if(err){
                    console.log(err);
                    details.status = 'failed';
                    res.status(401).json(details);
                    return;
                }
                else{
                    let appointmentDate = rows[0].appointmentDate;
                    if(rows.length != 0){
                        pool.query('INSERT INTO PAYMENT (doctorId,appointmentId,appointmentDate,consultationFee,slotId,payStatus) VALUES (?, ?, ?, 50, ?, 0)',[rows[0].doctorId, rows[0].appointmentId, appointmentDate, rows[0].slotId], function(err) {
                            if(err){
                                console.log(err);
                                details.status = 'failed';
                                res.status(401).json(details);
                                return;
                            }
                            else{
                                pool.query('delete from reservations where appointmentId = ?',[parseInt(rows[0].appointmentId)], function(err) {
                                    if(err){
                                        console.log(err);
                                        details.status = 'failed';
                                        res.status(401).json(details);
                                        return;
                                    }
                                    else{
                                        pool.query('select id, appointmentId from payment where doctorId = ? and appointmentId = ?',[rows[0].doctorId, rows[0].appointmentId], function(err, rows, fields){
                                            if(err){
                                                console.log(err);
                                                details.status = 'failed';
                                                res.status(404).json(details);
                                                return;
                                            }
                                            else{
                                                if(info.meds.length != 0){
                                                    for(let i=0; i< info.meds.length;i++){
                                                        pool.query('INSERT INTO MEDORDER (medicineId, paymentId, medOrderedQuantity, orderDate) VALUES (?,?, ?, ?)',[info.meds[i].id, rows[0].id, info.meds[i].count, appointmentDate], function(err){
                                                            if(err){
                                                                console.log(err);
                                                                details.status = 'failed';
                                                                res.status(401).json(details);
                                                                return;
                                                            }
                                                            else{
                                                                pool.query(`update medicines set mQuantity = mQuantity - ${info.meds[i].count} where id = ${info.meds[i].id}`, function(err) {
                                                                    if(err){
                                                                        console.log(err);
                                                                        details.status = 'failed';
                                                                        res.status(401).json(details);
                                                                        return;
                                                                    }
                                                                    else{
                                                                        if(i == info.meds.length-1){
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
                                                else{
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
                    else{
                        details.status = 'failed';
                        res.status(404).json(details);
                        return;
                    }
                }
            })
        }
    }) 
})

router.delete('/', credentialCheck, (req, res) => {
    let info = req.body;
    let details = {}
    pool.query('delete from reservations where appointmentId = ?',[info.appointmentId], function(err) {
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
})

module.exports = router;