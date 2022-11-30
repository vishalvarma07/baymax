let router = express.Router();
let pool = require('../resources');
let credentialCheck = require('../services/credentialCheck');

router.get('/', credentialCheck, (req, res) => {
    let details = {}
    pool.query('select * from patients', function(err){
        if(err){
            console.log(err);
            details.status = 'failed';
            res.status.json(details);
            return;
        }
        else{
            details.status = 'successful';
            res.status.json(details);
            return;
        }
    })
})