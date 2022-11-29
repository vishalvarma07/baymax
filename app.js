const mysql = require('mysql2');
const express = require('express');
const bodyParser = require('body-parser');
const frontendport = 52117;
const app = express();

//bodyParser is included implicitly in express
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

//Routers
loginRouter = require('./routes/login');
patientDashboardRouter = require('./routes/dashboard');
doctorDashboardRouter = require('./routes/doctorDashboard');
checkMedicineRouter = require('./routes/checkMedicines');
paymentRouter = require('./routes/payments');

//Routes
app.use('/login', loginRouter);
app.use('/dashboard', patientDashboardRouter);
app.use('/doctordashboard', doctorDashboardRouter);
app.use('/checkmedicine', checkMedicineRouter);
app.use('/payments', paymentRouter);

//test
app.currentUser = false;

app.listen(frontendport, () => {
    console.log("port 52117 accessed")
})

module.exports = app;