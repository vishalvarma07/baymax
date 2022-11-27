var express = require('express')
var router = express.Router();

var pool = require('../resources');
var app = require('../app');

router.get('/', (req, res) => {
    pool.query(`select mQuantity from medicines where id = ${req.body.id}`, function(err, rows, fields) {
        if(err){
            console.log(err);
            res.status(404).send({status: 'failed'});
        }
        if(rows[0].mQuantity < req.body.quantity){
            res.statusCode(404).send('Cant add more of this medicine');
        }
        else{
            res.statusCode(200).send('accepted');
        }
    })
})

module.exports = router;