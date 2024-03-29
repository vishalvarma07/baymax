let express = require('express');
router = express.Router();
const { createHash } = require('crypto');

let pool = require('../resources');

router.post('/', (req, res) => {
    const loginDetails = req.headers;
    //console.log(loginDetails);
    let details = {}
    if(loginDetails.login_type == 'user'){
        pool.query(`select * from ${loginDetails.user_type} where uname = ?`, [loginDetails.uname], function(err, rows, fields){
            if(err){
                console.log(err);
                details.status = 'failed'
                res.status(404).json(details);
                return;
            }
            if(rows.length == 0){
                details.status = 'failed';
                res.status(401).json(details);
                return;
            }
            else{
                if(rows[0].pwd == loginDetails.pwd){
                    console.log("login successful");
                    details.status = 'successful';
                    details.banned = Boolean(rows[0].ban);
                    res.status(201).json(details);
                    return;
                }
                else{
                    details.status = 'failed';
                    res.status(401).json(details);
                    return;
                }
            }
        })
    }
    else{
        pool.query(`select * from ${loginDetails.user_type} where uname = ?`,[loginDetails.uname], function(err, rows, fields){
            if(err){
                console.log(err);
                details.status = 'failed';
                res.status(404).json(details);
                return;
            }
            if(rows.length == 0){
                details.status = 'failed';
                res.status(401).json(details);
                return;
            }
            else{
                const currentYear = String(new Date().getFullYear());
                const currentMonth = String(new Date().getMonth()+1);
                console.log(currentMonth, currentYear);
                const key = rows[0].pwd + loginDetails.user_type +currentMonth + currentYear;
                const hash = createHash('sha256').update(key).digest('hex');
                if(hash == req.headers.pwd){
                    details.hash = rows[0].pwd;
                    details.status = 'successful';
                    console.log('login successful');
                    details.banned = Boolean(rows[0].ban);
                    res.status(201).json(details);
                    return;
                }
                else{
                    details.status = 'failed';
                    res.status(401).json(details);
                    return;
                }
            }
        })
    }
})

module.exports = router;