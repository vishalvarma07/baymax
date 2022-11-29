let express = require('express');
const pool = require('../resources');
let router = express.Router();

let app = require('../app');
let credentialCheck = require('../services/credentialCheck');

router.get('/',credentialCheck, (req, res) => {
    let userDetails = req.headers;
    let upcomingappointments = {};
    console.log(userDetails.uname);
    pool.query('select id from patient where uname = ?',[userDetails.uname], function(err, rows, fields) {
        if(err){
            upcomingappointments.status = 'successful';
            res.status(404).json(upcomingappointments);
        }
        let uid = rows[0].id;
        pool.query('select * from upcomingappointments where id = ?',[uid], function(err, rows, fields){
            if(err){
                console.log(err);
                upcomingappointments.status = 'failed';
                res.status(404).json(upcomingappointments);
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
                    }
                    else{
                        if(rows.length == 0){
                            upcomingappointments.status = 'successful';
                            upcomingappointments.yetTopay = 0;
                            upcomingappointments.yetToverify = 0;
                        }
                        else{
                            upcomingappointments.status = 'successful';
                            const yetTopay = parseInt(rows[0].noOfPaymentsYetToBePaid);
                            const yetToverify = rows[0].noOfPaymentsYetToBeVerified - yetTopay;
                            upcomingappointments.yetTopay = yetTopay;
                            upcomingappointments.yetToverify = yetToverify;
                        }
                        res.status(200).json(upcomingappointments);
                    }
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