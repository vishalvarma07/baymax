const mysql = require('mysql2');
const express = require('express');
const bodyParser = require('body-parser');
const frontendport = 52117;
const app = express();

//bodyParser is included implicitly in express
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

//Routers
signupRouter = require('./routes/signup');
loginRouter = require('./routes/login');
patientDashboardRouter = require('./routes/dashboard');
doctorDashboardRouter = require('./routes/doctorDashboard');
checkMedicineRouter = require('./routes/checkMedicines');
paymentRouter = require('./routes/payments');
patientProfileRouter = require('./routes/patientProfile');
doctorProfileRouter = require('./routes/doctorProfile');
passwordChangeRouter = require('./routes/passwordChange');
verifypayment = require('./routes/verifypayment');
userAccounts = require('./routes/useraccounts');

//Routes
app.use('/signup', signupRouter);
app.use('/login', loginRouter);
app.use('/dashboard', patientDashboardRouter);
app.use('/doctordashboard', doctorDashboardRouter);
app.use('/checkmedicine', checkMedicineRouter);
app.use('/payments', paymentRouter);
app.use('/patientprofile', patientProfileRouter);
app.use('/doctorprofile', doctorProfileRouter);
app.use('/passwordchange', passwordChangeRouter);
app.use('/verifypayment', verifypayment);
app.use('/useraccounts', userAccounts);

//cors
app.use(function(req, res, next) {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    res.setHeader('Access-Control-Allow-Credentials', true);
    next();
});

app.listen(frontendport, () => {
    console.log("port 52117 accessed")
})

module.exports = app;