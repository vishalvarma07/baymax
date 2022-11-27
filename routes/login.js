let express = require('express');
router = express.Router();

let pool = require('../resources');
let app = require('../app')

router.post('/', (req, res) => {
    const loginDetails = req.headers;
    let details = {}
    //console.log(req.body);
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
                //console.log(rows[0].id);
                app.currentUser = rows[0].id;
                details.status = 'successful'
                res.status(201).json(details);
            }
            else{
                details.status = 'failed';
                res.status(401).json(details);
            }
        }
    })
})

module.exports = router;