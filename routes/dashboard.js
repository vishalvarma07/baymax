let express = require('express');
const pool = require('../resources');
let router = express.Router();

let app = require('../app');
let credentialCheck = require('../services/credentialCheck');

router.get('/',credentialCheck, (req, res) => {
    let userDetails = req.headers;
    let upcomingappointments = {};
    console.log(userDetails.uname);
    pool.query('select id, fName from patient where uname = ?',[userDetails.uname], function(err, rows, fields) {
        if(err){
            console.log(err);
            upcomingappointments.status = 'failed';
            res.status(404).json(upcomingappointments);
            return;
        }
        else{
            let uid = rows[0].id;
            let patientName = rows[0].fName;
            upcomingappointments.patientName = patientName;
            pool.query('select height, weight, bloodType from patient where uname = ?',[userDetails.uname], function(err, rows, fields){
                if(err){
                    console.log(err);
                    upcomingappointments.status = 'failed';
                    res.status(404).json(upcomingappointments);
                    return;
                }
                else{
                    upcomingappointments.status = 'successful';
                    upcomingappointments.vitals = rows;
                    pool.query('select * from upcomingappointments where id = ?',[uid], function(err, rows, fields){
                        if(err){
                            console.log(err);
                            upcomingappointments.status = 'failed';
                            res.status(404).json(upcomingappointments);
                            return;
                        }
                        else{
                            if(rows.length == 0){
                                upcomingappointments.status = 'successful';
                                upcomingappointments.data = []
                            }
                            else{
                                upcomingappointments.status = 'successful';
                                upcomingappointments.data = rows;
                            }
                            pool.query('select * from alerts where id = ?',[uid], function(err, rows, fields){
                                if(err){
                                    console.log(err);
                                    upcomingappointments.status = 'failed';
                                    res.status(404).json(upcomingappointments);
                                    return;
                                }
                                else{
                                    if(rows.length == 0){
                                        upcomingappointments.status = 'successful';
                                        upcomingappointments.yetTopay = 0;
                                        upcomingappointments.yetToverify = 0;
                                        res.status(200).json(upcomingappointments);
                                        return;
                                    }
                                    else{
                                        upcomingappointments.status = 'successful';
                                        const yetTopay = parseInt(rows[0].noOfPaymentsYetToBePaid);
                                        const yetToverify = rows[0].noOfPaymentsYetToBeVerified - yetTopay;
                                        upcomingappointments.yetTopay = yetTopay;
                                        upcomingappointments.yetToverify = yetToverify;
                                        res.status(200).json(upcomingappointments);
                                        return;
                                    }
                                }
                            })
                        }
                    })
                }
            })
        }
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