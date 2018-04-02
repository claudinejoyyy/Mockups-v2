module.exports = function(app,db,name,counts,chart,whoCurrentlyAdmitted,whoOPD,whoWARD,monthlyPatientCount,patientList,bcrypt,io,moment){
var user, Aid;
var prescriptionSQL = 'SELECT CONCAT("medicine:",medicine,"\nquantity:",quantity,"\ndosage:", dosage,"\ntimeframe:", timeframe) AS medications, p.status as STATUS,creation_stamp,patient_type,name,age,prescription_id from prescription p inner join patient using(patient_id) where p.status = "pending";';
var confirmedprescriptionSQL = 'SELECT CONCAT("medicine:",medicine,"\nquantity:",quantity,"\ndosage:", dosage,"\ntimeframe:", timeframe) AS medications, p.status as STATUS,creation_stamp,patient_type,name,age,prescription_id from prescription p inner join patient using(patient_id) where p.status = "confirmed";';

  app.get('/pharmacist/dashboard', function(req, res){
    if(req.session.email && req.session.sino == 'pharmacist'){
      if(req.session.sino == 'pharmacist'){
        Aid = req.session.Aid;
        var prescriptionSQL    = "SELECT * from prescription inner join patient using(patient_id);";
        var acceptedRequestSQL = 'SELECT * from prescription r inner join patient p using(patient_id) where r.status="confirmed";';
        var pendingRequestSQL  = 'SELECT * from prescription r inner join patient p using(patient_id) where r.status="pending";';
        var todoList           = "SELECT * from todo_list where account_id = "+Aid+";";
        db.query(prescriptionSQL + acceptedRequestSQL + pendingRequestSQL + todoList + monthlyPatientCount + name + prescriptionSQL + confirmedprescriptionSQL, Aid, function(err, rows){
          if (err) {
            console.log(err);
          } else {
            user = rows[5];
            res.render('pharmacist/dashboard', {prescriptionInfo:rows[0], accepted:rows[1], pending:rows[2], todoList:rows[3], monthlyPatientCount:rows[4] ,prescriptionDetails:rows[6] ,confirmedprescriptionSQL:rows[7] , username:user});
          }
        });
      } else {
        res.redirect(req.session.sino+'/dashboard');
      }
    } else {
        res.redirect('../login');
    }
  });
  app.post('/pharmacist/dashboard', function(req, res){
    var data = req.body;
    if (req.session.email && req.session.sino == 'pharmacist') {
      if (req.session.sino == 'pharmacist') {
        if(data.sub == 'addTodo') {
            var splitDateNTime = data.dateNtime.split('T');
            var parseDate      = splitDateNTime[0];
            var parseTime      = splitDateNTime[1] + ':00';
            var parseDateNTime = parseDate+' '+parseTime;
            var todoLog = '';
            if (data.todoStatus == 'urgent') {
              todoLog = 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+req.session.Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "urgentTodo", "Added to do urgent: '+data.description+'");';
            } else if(data.todoStatus == 'general') {
              todoLog = 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+req.session.Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "generalTodo", "Added to do general: '+data.description+'");';
            }
            var addTodo  = 'INSERT into todo_list (description, status,date, account_id) VALUES("'+data.description+'","'+data.todoStatus+'","'+parseDateNTime+'",'+req.session.Aid+');';
            db.query(addTodo + todoLog, function(err){
              if (err) {
                console.log(err);
              }
            });
            res.redirect(req.get('referer'));
          } else if (data.sub == 'delToDo') {
            var delTodo = 'DELETE FROM todo_list where todo_id = '+req.query.tId+';';
            db.query(delTodo + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+req.session.Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "delTodo", "Deleted data from todo List");', function(err){
              if (err) {
                console.log(err);
              }
            });
            res.redirect(req.get('referer'));

        } else if(data.sub == 'appointment') {
              var splitDateNTime = data.dateNtime.split('T');
              var parseDate      = splitDateNTime[0];
              var parseTime      = splitDateNTime[1] + ':00';
              var parseDateNTime = parseDate+' '+parseTime;
              var addAppointment = 'INSERT into appointment (doctor_id, patient_id, appointment_timestamp, remarks) VALUES ('+Aid+', '+data.appointmentPatientID+', "'+parseDateNTime+'", "'+data.appointmentRemarks+'");';
              db.query(addAppointment + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "appointment", "Set Appointment with '+req.query.appointmentPatientName+' on '+parseDateNTime+'");', function(err){
                if (err) {
                  console.log(err);
                }
              });
              res.redirect(req.get('referer'));
        }

  } else {
    res.redirect(req.session.sino + '/dashboard');
  }
} else {
res.redirect('../login');
    }
  });

  //PATIENT MANAGEMENT
  app.get('/pharmacist/patientManagement', function(req, res){
      if(req.session.email && req.session.sino == 'pharmacist'){
        if(req.session.sino == 'pharmacist'){
          var sql  = "SELECT * FROM patient";

          db.query(sql, Aid, function(err, rows, fields){
            res.render('pharmacist/patientManagement', {p:rows, username: user});
          });
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
          res.redirect('../login');
      }
    });
    //PRESCRIPTION
    app.get('/pharmacist/prescriptionManagement', function(req, res){
      if(req.session.email && req.session.sino == 'pharmacist'){
        if(req.session.sino == 'pharmacist'){

          db.query(prescriptionSQL + confirmedprescriptionSQL, function(err, rows){
            if (err) {
              console.log(err);
            } else {
              res.render('pharmacist/prescriptionManagement', {prescriptionDetails:rows[0], confirmedprescriptionSQL:rows[1], username:user});
            }
          });
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
          res.redirect('../login');
      }
    });
    app.post('/pharmacist/prescriptionManagement', function(req, res){
      var data = req.body;
      if(req.session.email && req.session.sino == 'pharmacist'){
        if(req.session.sino == 'pharmacist') {
          if (data.sub == 'confirm') {
            var confirmPrescriptionSQL = 'UPDATE prescription set status = "confirmed" where prescription_id = '+req.query.prescriptionId+';';
            db.query(confirmPrescriptionSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "approvedPrescription", "Approved prescription for: '+req.query.prescriptionPatientName+'");', function(err){
              if(err){
                console.log(err);
              } else {
                io.emit('type', {what:'confirmedPrescription',message:'Confirmed Prescription for <strong>'+req.query.prescriptionPatientName+'</strong>'});
                res.redirect(req.get('referer'));
              }
            });
          } else {
            var cancelPrescriptionSQL = 'DELETE FROM prescription where prescription_id = '+req.query.prescriptionId+';';
            db.query(cancelPrescriptionSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "cancelPrescription", "Canceled prescription for: '+req.query.prescriptionPatientName+'");', function(err){
              if(err){
                console.log(err);
              } else {
                io.emit('type', {what:'cancelPrescription',message:'Confirmed Lab Request for <strong>'+req.query.prescriptionPatientName+'</strong>'});
                res.redirect(req.get('referer'));
              }
            });

          }
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
        res.redirect('../login');
      }
    });
    
// PROFILE MANAGEMENT
    app.get('/pharmacist/profileManagement', function(req, res){
      if(req.session.email && req.session.sino == 'pharmacist'){
        if (req.session.sino == 'pharmacist') {
          var profileInfoSQL  = 'SELECT name, age, account_id, sex, address, phone from user_accounts where account_id = '+req.session.Aid+';';
          var activityLogsSQL = 'SELECT * from activity_logs where account_id = '+req.session.Aid+' ORDER by logs_id desc LIMIT 10;';
          db.query(profileInfoSQL + activityLogsSQL, function(err, rows){
            if (err) {
              console.log(err);
            } else {
              res.render('pharmacist/profileManagement', {pInfo:rows[0], activityInfo: rows[1], username: user});
            }
          });
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
        res.redirect('../login')
      }
    });

    app.post('/pharmacist/profileManagement', function(req, res){
      var data = req.body;
      if (req.session.email && req.session.sino == 'pharmacist') {
        if (req.session.sino == 'pharmacist') {
          bcrypt.compare(data.oldPass, req.session.password, function(err, isMatch){
            if(isMatch) {
              req.flash('success', 'Successfully changed profile!');
              bcrypt.genSalt(10, function(err, salt){
                bcrypt.hash(data.newPass, salt, function(err, hash){
                  if (data.newPass) {
                    var updateProfileSQL = 'UPDATE user_accounts SET name = "'+data.name+'", address = "'+data.address+'", phone = '+data.phone+', password = "'+hash+'" WHERE account_id = '+req.session.Aid+';';
                    db.query(updateProfileSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "settingsProfileManagement", "Edited personal info.");', function(err, rows){
                      if (err) {
                        console.log(err);
                      } else {
                          res.redirect('../logout');
                      }
                    });                    
                  } else {
                    var updateProfileSQL = 'UPDATE user_accounts SET name = "'+data.name+'", address = "'+data.address+'", phone = '+data.phone+' WHERE account_id = '+req.session.Aid+';';
                    db.query(updateProfileSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "settingsProfileManagement", "Edited personal info.");', function(err, rows){
                      if (err) {
                        console.log(err);
                      } else {
                          res.redirect(req.get('referer'));
                      }
                    });                    
                  }
                });
              });
            } else {
              req.flash('danger', 'Invalid Current Password!');
              res.redirect(req.get('referer'));
            }
          });

        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
        res.redirect('../login');
      }
    });

    // REPORTS MANAGEMENT
    app.get('/pharmacist/reports', function(req, res){
      if(req.session.email && req.session.sino == 'pharmacist'){
        if (req.session.sino == 'pharmacist') {
          //var reportsSQL  = 'SELECT * from prescription inner join patient using(patient_id);';
          var pharmReport = 'select p.patient_type, CONCAT(p.rankORsn, " ", p.name) as patients,  CONCAT(m.medicine, " ", m.dosage) as med, m.quantity, m.creation_stamp from patient as p join prescription as m using (patient_id) where m.status = "confirmed" and date_format(m.creation_stamp, "%M %d %Y") = date_format(now(), "%M %d %Y") order by p.patient_type;';
          db.query(pharmReport, function(err, rows){
            if (err) {
              console.log(err);
            } else {
              // var updateReportPrescription = 'insert into daily_consumption_report(date, patient_type, patient_name, medicine, qty) values("'+pharmReport.datestamp+'", "'+pharmReport.patient_type+'", "'+pharmReport.patients+'", "'+pharmReport.med+'", "'+pharmReport.quantity+'");';
              // db.query(updateReportPrescription, function(err, rows){
              //   if (err){
              //     console.log(err);
              //   }
              // });
              res.render('pharmacist/reports', {reportsInfo:rows, username:user});
            }
          });
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
        res.redirect('../login')
      }
    });


}
