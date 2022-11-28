let express = require('express');
router = express.Router();
const { createHash } = require('crypto');

let pool = require('../resources');
let app = require('../app')

router.post('/', (req, res) => {
    const loginDetails = req.headers;
    const loginType = req.body.loginType;
    let details = {}
    if(loginType == false){
        pool.query('select * from patient where uname = ?', [loginDetails.uname], function(error, rows, fields){
            if(error){
                console.log(err);
                details.status = 'failed'
                res.status(404).json(details);
            }
            if(rows.length == 0){
                details.status = 'failed';
                res.status(401).json(details);
            }
            else{
                if(rows[0].pwd == loginDetails.pwd){
                    console.log("login successful");
                    details.status = 'successful'
                    res.status(201).json(details);
                }
                else{
                    details.status = 'failed';
                    res.status(401).json(details);
                }
            }
        })
    }
    else{
        pool.query('select * from patient where uname = ?',[loginDetails.uname], function(err, rows, fields){
            if(err){
                console.log(err);
                details.status = 'failed';
                res.status(404).json(details);
            }
            if(rows.length == 0){
                details.status = 'failed';
                res.status(401).json(details);
            }
            else{
                const currentYear = String(new Date().getFullYear);
                const currentMonth = String(new Date().getMonth);
                const key = rows[0].pwd + currentMonth + currentYear;
                const hash = createHash('sha256').update(key).digest('hex');
                if(hash == req.body.hash){
                    details.hash = hash;
                    details.status = 'successful';
                    res.status(200).json(details);
                }
                else{
                    details.status = 'failed';
                    res.status(401).json(details);
                }
            }
        })
    }
})

module.exports = router;