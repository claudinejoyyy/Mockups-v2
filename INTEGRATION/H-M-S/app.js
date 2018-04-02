var db = require("./database/db.js");
var login = require('./controllers/routes');
var nurse = require('./controllers/nurseRoute');
var doctor = require('./controllers/doctorRoute');
var admin = require('./controllers/adminRoute');
var laboratorist = require('./controllers/laboratoristRoute');
var pharmacist = require('./controllers/pharmacistRoute');
var bodyParser = require('body-parser');
var session = require('express-session');
var express = require('express');
var moment = require('moment');
var helmet = require('helmet');
var bcrypt = require('bcryptjs');
var expressValidator = require('express-validator');
var flash = require('connect-flash');
var app = express();

//MIDDLEWARES
app.locals.moment = require('moment');
app.set('view engine', 'ejs');
app.use(helmet.noCache());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true}));
app.use(express.static('./public'));
app.use(session({secret: 'shhhhh', cookie: { maxAge: 3600000 }}));

// Run server to listen on port 3000.
const server = app.listen(3000, () => {
  console.log('--listening on port 3000--');
});
const io = require('socket.io')(server);

//FOR AGE INCREMENT
var pharmDailyReport;
var CronJob = require('cron').CronJob;
new CronJob('00 00 * * 1-7', function() {
    var checkBD = 'SELECT name, patient_id, birth_date, age from patient';
    db.query(checkBD, function(err, rows){
      var resultDB = JSON.parse(JSON.stringify(rows));
      for (var i in resultDB) {
        if (moment(new Date()).format('MM-DD') == moment(resultDB[i].birth_date).format('MM-DD')) {
          db.query('UPDATE patient SET age='+JSON.parse(resultDB[i].age+1)+' where patient_id ='+resultDB[i].patient_id+';', function(err){
            if (err) {
              console.log(err);
            } else {
              console.log('patient: '+resultDB[i].name+' is now '+JSON.parse(resultDB[i].age+1)+'');
            }
          });
        }
      }

      var pharmReport = 'select p.patient_type, p.rankORsn, p.name, CONCAT(m.dosage, " ", m.medicine) as med, m.quantity, m.creation_stamp from patient as p join prescription as m using (patient_id) where m.status = "confirmed" and date_format(m.creation_stamp, "%M %d %Y") = date_format(now(), "%M %d %Y") order by p.patient_type';
      db.query(pharmReport, function(rows){
        var pharmDailyReport = rows;
      });
    });
}, null, true);

//RESET COUNTER EVERY 3 MONTHS
  new CronJob('00 00 1 mar,jun,sep,dec *', function() {
     db.query("DELETE from opd_count;" + "DELETE from ward_count;" + "DELETE from lab_counter;",function(err){
       if (err) {
         console.log(err);
       } else {
         console.log('MONTHLY RESET OF COUNTER');
       }
     });
 }, null, true);

// Express Validator Middleware
app.use(expressValidator({
  errorFormatter: function(param, msg, value) {
      var namespace = param.split('.')
      , root    = namespace.shift()
      , formParam = root;

    while(namespace.length) {
      formParam += '[' + namespace.shift() + ']';
    }
    return {
      param : formParam,
      msg   : msg,
      value : value
    };
  }
}));

//Express Messages Middleware
app.use(require('connect-flash')());
app.use(function (req, res, next) {
  res.locals.messages = require('express-messages')(req, res);
  next();
});



//PARA sa DASHBOARD of all MODULES!!!
var name   = "SELECT name,account_type FROM user_accounts where account_id = ?;";
var counts = "SELECT (SELECT COUNT(opd_count_id) from opd_count) as OPD, "
            +"(SELECT COUNT(ward_count_id) from ward_count) as WARD,"
            +"(SELECT count(name) pCount FROM patient) as totalRegisteredPatients,"
            +"(SELECT count(patient_id) admitted FROM bed) as currentlyAdmitted;";
var chart  = "SELECT  (SELECT count(patient_id) from patient where patient_type = 'cadet') as cadet,"
            +"(SELECT count(patient_id) from patient where patient_type = 'military officer') as military_officer,"
            +"(SELECT count(patient_id) from patient where patient_type = 'military dependent') as military_dependent,"
            +"(SELECT count(patient_id) from patient where patient_type = 'civilian') as civilian,"
            +"(SELECT count(patient_id) from patient where patient_type = 'authorized civilian') as authorized_civilian;";
//COUNT
var whoOPD               = "SELECT p.name, a.time From patient p inner join activity_logs a USING(patient_id) where a.type = 'initialAssessment';";
var whoWARD              = "SELECT p.name, a.time From patient p inner join activity_logs a USING(patient_id) where a.type = 'bed';";
var whoCurrentlyAdmitted = "SELECT p.name, a.patient_id, a.bed_id FROM bed a INNER JOIN patient p USING(patient_id);";
// GRAPH
var currentYear = moment(new Date()).format('YYYY');
var monthlyPatientCount  = 'SELECT (SELECT count(logs_id) from activity_logs WHERE time BETWEEN "'+currentYear+'-01-01 00:00:00" and "'+currentYear+'-02-01 00:00:00" and type = "add") as JAN,'
                          +'(SELECT count(logs_id) from activity_logs WHERE time BETWEEN "'+currentYear+'-02-01 00:00:00" and "'+currentYear+'-03-01 00:00:00" and type = "add") as FEB,'
                          +'(SELECT count(logs_id) from activity_logs WHERE time BETWEEN "'+currentYear+'-03-01 00:00:00" and "'+currentYear+'-04-01 00:00:00" and type = "add") as MARCH,'
                          +'(SELECT count(logs_id) from activity_logs WHERE time BETWEEN "'+currentYear+'-04-01 00:00:00" and "'+currentYear+'-05-01 00:00:00" and type = "add") as APRIL,'
                          +'(SELECT count(logs_id) from activity_logs WHERE time BETWEEN "'+currentYear+'-05-01 00:00:00" and "'+currentYear+'-06-01 00:00:00" and type = "add") as MAY,'
                          +'(SELECT count(logs_id) from activity_logs WHERE time BETWEEN "'+currentYear+'-06-01 00:00:00" and "'+currentYear+'-07-01 00:00:00" and type = "add") as JUNE,'
                          +'(SELECT count(logs_id) from activity_logs WHERE time BETWEEN "'+currentYear+'-07-01 00:00:00" and "'+currentYear+'-08-01 00:00:00" and type = "add") as JULY,'
                          +'(SELECT count(logs_id) from activity_logs WHERE time BETWEEN "'+currentYear+'-08-01 00:00:00" and "'+currentYear+'-09-01 00:00:00" and type = "add") as AUGUST,'
                          +'(SELECT count(logs_id) from activity_logs WHERE time BETWEEN "'+currentYear+'-09-01 00:00:00" and "'+currentYear+'-010-01 00:00:00" and type = "add") as SEPTEMBER,'
                          +'(SELECT count(logs_id) from activity_logs WHERE time BETWEEN "'+currentYear+'-010-01 00:00:00" and "'+currentYear+'-011-01 00:00:00" and type = "add") as OCTOBER,'
                          +'(SELECT count(logs_id) from activity_logs WHERE time BETWEEN "'+currentYear+'-011-01 00:00:00" and "'+currentYear+'-012-01 00:00:00" and type = "add") as NOVEMBER,'
                          +'(SELECT count(logs_id) from activity_logs WHERE time BETWEEN "'+currentYear+'-012-01 00:00:00" and "'+currentYear+'-001-01 00:00:00" and type = "add") as DECEMBER;';
//TO DO LIST
//OTHERS
var patientList          = "SELECT * from patient;";
var doctorList           = "SELECT * FROM user_accounts WHERE account_type = 'doctor';";
var availableBeds        = "SELECT b.bed_id, p.patient_type, p.name, b.status, b.allotment_timestamp from bed b LEFT JOIN patient p USING(patient_id) where b.status = 'Unoccupied';";


var patientManagementSQL = "SELECT *,"
                           +" (SELECT time from activity_logs where type='bed' and patient.patient_id = activity_logs.patient_id order by time desc limit 1) as allotment, "
                           +" (SELECT time from activity_logs where type='bedDischarge' and patient.patient_id = activity_logs.patient_id order by time desc limit 1) as discharge, "
                           +" (SELECT DATEDIFF(discharge,allotment)) as difference "
                           +" FROM patient left join activity_logs USING(patient_id) group by patient_id;";

login (app,db,bcrypt,moment);
nurse (app,db,name,counts,chart,whoCurrentlyAdmitted,whoOPD,whoWARD,monthlyPatientCount,patientList,availableBeds,doctorList,patientManagementSQL,bcrypt,io,moment);
doctor(app,db,name,counts,chart,whoCurrentlyAdmitted,whoOPD,whoWARD,monthlyPatientCount,patientList,availableBeds,patientManagementSQL,bcrypt,io,moment);
admin (app,db,name,counts,chart,whoCurrentlyAdmitted,whoOPD,whoWARD,monthlyPatientCount,patientList,availableBeds,patientManagementSQL,bcrypt,io,moment);
pharmacist(app,db,name,counts,chart,whoCurrentlyAdmitted,whoOPD,whoWARD,monthlyPatientCount,patientList,bcrypt,io,moment,pharmDailyReport);
laboratorist(app,db,name,counts,chart,whoCurrentlyAdmitted,whoOPD,whoWARD,monthlyPatientCount,patientList,bcrypt,io,moment);
