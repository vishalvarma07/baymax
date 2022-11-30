let express = require('express');
let router = express.Router();
let pool = require('../resources');
let credentialCheck = require('../services/credentialCheck');

router.get('/', credentialCheck, (req, res) => {
    
})