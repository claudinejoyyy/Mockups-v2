module.exports = function(app,db,name,counts,chart,whoCurrentlyAdmitted,whoOPD,whoWARD,monthlyPatientCount,patientList,availableBeds,patientManagementSQL,bcrypt,io,moment){
var user, Aid, availableBedss, p;

  app.get('/doctor/dashboard', function(req, res){
    if(req.session.email && req.session.sino == 'doctor'){
      Aid = req.session.Aid;
      if(req.session.sino == 'doctor'){
        var todoList    = "SELECT * from todo_list where account_id = "+Aid+";";
        db.query(name + counts + chart + whoCurrentlyAdmitted + whoOPD + whoWARD + patientList + availableBeds + monthlyPatientCount + todoList, Aid, function(err, rows, fields){
          if (err) {
            console.log(err);
          }
          user = rows[0];
          availableBedss = rows[7];
          res.render('doctor/dashboard', {counts:rows[1], chart:rows[2], whoCurrentlyAdmitted:rows[3], whoOPD:rows[4], whoWARD:rows[5], patientList:rows[6],
                                         availableBeds:rows[7], monthlyPatientCount:rows[8], todoList:rows[9], username: user});
       });
      } else {
        res.redirect(req.session.sino + '/dashboard');
      }
    } else {
      res.redirect('../login');
    }
  });

  app.post('/doctor/dashboard', function(req, res){
    var data = req.body;
    if(req.session.email && req.session.sino == 'doctor'){
        if (req.session.sino == 'doctor') {
          if(data.sub == 'addTodo') {
            var splitDateNTime = data.dateNtime.split('T');
            var parseDate      = splitDateNTime[0];
            var parseTime      = splitDateNTime[1] + ':00';
            var parseDateNTime = parseDate+' '+parseTime;
            var todoLog = '';
            if (data.todoStatus == 'urgent') {
              console.log('Added to urgent!!!!');
              todoLog = 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+req.session.Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "urgentTodo", "Added to do urgent: '+data.description+'");';
            } else if(data.todoStatus == 'general') {
              console.log('Added to general!!!!');
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
//OUTPATIENT
  app.get('/doctor/outpatientManagement', function(req, res){
    if(req.session.email && req.session.sino == 'doctor'){
      if (req.session.sino == 'doctor') {
          var outpatientDepartmentSQL = 'SELECT * from patient_history inner join patient using(patient_id) where patient_history.status = "pending" and bed is null;';
          var outpatientDepartmentSQL2 = 'SELECT * from patient_history inner join patient using(patient_id) where patient_history.status = "confirmed";';
          var outpatientDepartmentSQL3 = 'SELECT * from patient_history inner join patient using(patient_id) left join bed using(patient_id) where patient_history.status = "pending" and bed is not null group by patient_id;';
          var labSQL                  = 'SELECT * from lab_request left join patient_history using(patient_id)  where lab_status = "pending" group by patient_id;';
          var prescribeSQL            = 'SELECT * from prescription p inner join patient using(patient_id) where p.status = "pending" group by patient_id;';

          db.query(outpatientDepartmentSQL + availableBeds + labSQL + prescribeSQL + outpatientDepartmentSQL2 + outpatientDepartmentSQL3, function(err, rows){
          if (err) {
            console.log(err);
          } else {
              res.render('doctor/outpatientManagement', {opdInfo:rows[0], admitAvailableBeds:rows[1], labSQL:rows[2], prescribeSQL:rows[3], opdInfo1:rows[4], opdInfo2:rows[5], username: user});
          }
        });
      } else {
        res.redirect(req.session.sino+'/dashboard');
      }
    } else {
      res.redirect('../login')
    }
  });
  app.post('/doctor/outpatientManagement', function(req, res){
    var data = req.body;
    if(req.session.email && req.session.sino == 'doctor'){
      if (req.session.sino == 'doctor') {
          if (data.sub == 'admit') {
            var bedSQL = 'UPDATE bed set allotment_timestamp = "'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", patient_id = '+req.query.patient_id+',status = "occupied" where bed_id = '+data.bedNumber+';';
            var historySQL = 'UPDATE patient_history set bed = CONCAT(IFNULL(bed, ""),"'+data.bedNumber+', ") where histo_id ='+req.query.histo_id+';';
            db.query(bedSQL + historySQL + 'INSERT into activity_logs(account_id, time, type, remarks, patient_id) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "bed", "Alloted bed number: '+data.bedNumber+' to patient:'+req.query.patient_name+'",'+req.query.patient_id+');', function(err){
              if (err) {
                console.log(err);
              } else {
                res.redirect(req.get('referer'));
              }
            });
          } else if(data.sub == 'prescribe') {
            var prescribeSQL = 'INSERT into prescription (creation_stamp, medicine, quantity, dosage, timeframe, doctor_id, patient_id, status) VALUES ("'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'","'+data.medicine+'",'+data.quantity+',"'+data.dosage+'","'+data.timeframe+'",'+Aid+','+req.query.patient_id+',"pending");';
            var medicines    = "Medicine:" + data.medicine + ", Quantity:"+ data.quantity + ", Dosage:" + data.dosage + ", TimeFrame:" + data.timeframe;
            var historySQL = 'UPDATE patient_history set medicine = CONCAT(IFNULL(medicine, ""),"'+medicines+'\n") where histo_id ='+req.query.histo_id+';';
            db.query(prescribeSQL + historySQL +  'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "prescription", "Prescribed a medicine to : '+req.query.patient_name+'");', function(err){
              if (err) {
                console.log(err);
              } else {
                io.emit('type', {what:'prescribe',message:'Received Prescription for '+req.query.patient_name+', sent by Dr. <strong>'+req.session.name+'</strong>'});
                res.redirect(req.get('referer'));
              }
            });
          } else if (data.sub == 'labRequest') {
            var requestSQL = 'INSERT into lab_request(type,timestamp,remarks,doctor_id,patient_id,lab_status) VALUES("'+data.testRequest+'","'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'","'+data.labRequestremarks+'",'+Aid+','+req.query.patient_id+',"pending");';
            var lab = "Type:" + data.testRequest + " Remarks:" + data.labRequestremarks;
            var historySQL = 'UPDATE patient_history set lab = CONCAT(IFNULL(lab, ""),"'+lab+'\n") where histo_id = '+req.query.histo_id+';';
            db.query(requestSQL + historySQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "labRequest", "Lab request for : '+req.query.patient_name+'");', function(err){
              if (err) {
                console.log(err);
              } else {
                io.emit('type', {what:'lab',message:'Received Lab Request for '+req.query.patient_name+', sent by Dr. <strong>'+req.session.name+'</strong>'});
                res.redirect(req.get('referer'));
              }
            });
          } else if (data.sub == 'diag') {
            var diagnosisSQL = 'INSERT into diagnosis (diagnosis, date, patient_id, doctor_id) VALUES ("'+data.diagnosis+'","'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'",'+req.query.patient_id+','+Aid+');';
            var historySQL = 'UPDATE patient_history set diagnosis = CONCAT(IFNULL(diagnosis, ""),"'+data.diagnosis+'\n") where histo_id = '+req.query.histo_id+';';
            db.query(diagnosisSQL + historySQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "diagnosis", "diagnosis for : '+req.query.patient_name+'");', function(err){
              if (err) {
                console.log(err);
              } else {
                res.redirect(req.get('referer'));
              }
            });
          } else if (data.sub == 'confirm') {
            db.query('UPDATE patient_history inner join bed on patient_history.patient_id = bed.patient_id set patient_history.status = "confirmed", bed.status = "Unoccupied", bed.allotment_timestamp = NULL, bed.patient_id = NULL where patient_history.histo_id = '+req.query.id+';', function(err){
              if (err) {
                console.log(err);
              } else {
                res.redirect(req.get('referer'));
              }
            });
          } else if (data.sub == 'clear'){
            db.query('UPDATE patient_history set diagnosis = NULL where histo_id = '+req.query.histo_id+';', function(err){
              if (err) {
                console.log(err);
              } else {
                res.redirect(req.get('referer'));
              }
            });
          }
      } else {
        res.redirect(req.session.sino+'/dashboard');
      }
    } else {
      res.redirect('../login')
    }
  });
  //BED MANAGEMENT
  app.get('/doctor/bedManagement', function(req, res){
    if (req.session.email && req.session.sino == 'doctor') {
      if (req.session.sino == 'doctor') {
        if (req.query.bed_id) {
          var bedSQL = "SELECT p.patient_id, b.bed_id, p.patient_type, p.name, b.status, b.allotment_timestamp from bed b LEFT JOIN patient p USING(patient_id) where bed_id = "+req.query.bed_id+"; ";
          db.query(bedSQL, function(err, rows, fields){
            res.render('doctor/bedManagement', {bedDetails:rows, username: user});
          });
        } else {
          var bedSQL = "SELECT p.patient_id, b.bed_id, p.patient_type, p.name, b.status, b.allotment_timestamp from bed b LEFT JOIN patient p USING(patient_id); ";
          db.query(bedSQL, function(err, rows, fields){
            res.render('doctor/bedManagement', {bedDetails:rows, username: user});
          });
        }
      } else {
        res.redirect(req.session.sino+'/dashboard');
      }
    } else {
      res.redirect('../login');
    }
  });
  app.post('/doctor/bedManagement', function(req, res){
    if(req.session.email && req.session.sino == 'doctor'){
      if(req.session.sino == 'doctor') {
        var dischargeSQL = "UPDATE bed SET status = 'Unoccupied', allotment_timestamp = NULL, patient_id = NULL where bed_id = "+req.query.bed+";";
        db.query(dischargeSQL + 'INSERT into activity_logs(account_id, time, type, remarks, patient_id) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "bedDischarge", "Discharged a patient from bed number : '+req.query.bed+'", '+req.query.id+');', function(err, rows, fields){
          if(err){
            console.log(err);
          } else {
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
  //PATIENT MANAGEMENT
  app.get('/doctor/patientManagement', function(req, res){
      if(req.session.email && req.session.sino == 'doctor'){
        if(req.session.sino == 'doctor'){
          if(req.query.patient){
            var sql  = "SELECT patient_id,patient_type,name,age,sex,blood_type FROM patient where patient_id = "+req.query.patient+";";
            db.query(sql, function(err, rows){
              res.render('doctor/patientManagement', {p:rows, p2:null, med:null, username:user, invalid:null});
            });
          } else {
              db.query(patientManagementSQL, function(err, rows){
                res.render('doctor/patientManagement', {p:rows, p2:null, med:null, username:user, invalid:null});
              });
          }
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
          res.redirect('../login');
      }
    });
    app.post('/doctor/patientManagement', function(req, res){
      var data = req.body;
      if(req.session.email && req.session.sino == 'doctor'){
        if(req.session.sino == 'doctor') {

          bcrypt.compare(data.patientPassword, req.session.password, function(err, isMatch){
            if (err) {
              console.log(err);
            } else if(isMatch) {
              var sql  = "SELECT patient_id,patient_type,name,age,sex,blood_type FROM patient where patient_id = "+req.query.passPatient+";";
              var sql2  = "SELECT * FROM patient where patient_id = "+req.query.passPatient+";";
              var med = "select date_stamp, lab, medicine,diagnosis,bed from patient_history where patient_id = "+req.query.passPatient+" order by date_stamp;";
              db.query(sql + sql2 + med, function(err, successRows){
                res.render('doctor/patientManagement', {p:successRows[0], p2:successRows[1], med:successRows[2], username:user, invalid:null});
              });
            } else {
              var sql  = "SELECT patient_id,patient_type,name,age,sex,blood_type FROM patient where patient_id = "+req.query.passPatient+";";
              db.query(sql, function(err, errorRows){
                res.render('doctor/patientManagement', {p:errorRows, p2:null, med:null, username:user, invalid:'error'});
              });
            }
          });
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
        res.redirect('../login');
      }
    });
    //APPOINTMENT
    app.get('/doctor/appointmentManagement', function(req, res){
      if(req.session.email && req.session.sino == 'doctor'){
        if(req.session.sino == 'doctor'){
          var appointmentSQL = 'SELECT * from appointment a inner join patient using(patient_id) where doctor_id = '+Aid+';';

          db.query(appointmentSQL, function(err, rows){
            if (err) {
              console.log(err);
            } else {
              res.render('doctor/appointmentManagement', {appointmentDetails:rows, username: user});
            }
          });
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
          res.redirect('../login');
      }
    });
    app.post('/doctor/appointmentManagement', function(req, res){
      if(req.session.email && req.session.sino == 'doctor'){
        if(req.session.sino == 'doctor') {
          var cancelAppointmentSQL = 'DELETE from appointment where appointment_id = '+req.query.appointmentId+';';
          db.query(cancelAppointmentSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "cancelAppointment", "Canceled appointment with: '+req.query.appointmentPatientName+'");', function(err){
            if(err){
              console.log(err);
            } else {
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
    //PRESCRIPTION
    app.get('/doctor/prescriptionManagement', function(req, res){
      if(req.session.email && req.session.sino == 'doctor'){
        if(req.session.sino == 'doctor'){
          if (req.query.opdPatient) {
            var prescriptionSQL = 'SELECT CONCAT("medicine:",medicine,"\nquantity:",quantity,"\ndosage:", dosage,"\ntimeframe:", timeframe) AS medications, p.status as STATUS,creation_stamp,patient_type,name,age,prescription_id from prescription p inner join patient using(patient_id) where doctor_id = '+Aid+' and patient_id = '+req.query.opdPatient+' and p.status ="pending" ORDER BY creation_stamp desc;';
            var confirmedprescriptionSQL = 'SELECT CONCAT("medicine:",medicine,"\nquantity:",quantity,"\ndosage:", dosage,"\ntimeframe:", timeframe) AS medications, p.status as STATUS,creation_stamp,patient_type,name,age,prescription_id from prescription p inner join patient using(patient_id) where p.status = "confirmed" and doctor_id='+Aid+' ORDER BY creation_stamp desc;';

            db.query(prescriptionSQL+confirmedprescriptionSQL, function(err, rows){
              if (err) {
                console.log(err);
              } else {
                res.render('doctor/prescriptionManagement', {prescriptionDetails:rows[0], confirmedprescriptionSQL:rows[1], opdPatientInfo:req.query.opdPatient, username: user});
              }
            });
          } else {
            var prescriptionSQL = 'SELECT CONCAT("medicine:",medicine,"\nquantity:",quantity,"\ndosage:", dosage,"\ntimeframe:", timeframe) AS medications, p.status as STATUS,creation_stamp,patient_type,name,age,prescription_id from prescription p inner join patient using(patient_id) where doctor_id = '+Aid+' and p.status ="pending" ORDER BY creation_stamp desc;';
            var confirmedprescriptionSQL = 'SELECT CONCAT("medicine:",medicine,"\nquantity:",quantity,"\ndosage:", dosage,"\ntimeframe:", timeframe) AS medications, p.status as STATUS,creation_stamp,patient_type,name,age,prescription_id from prescription p inner join patient using(patient_id) where p.status = "confirmed" and doctor_id='+Aid+' ORDER BY creation_stamp desc;';

            db.query(prescriptionSQL+confirmedprescriptionSQL, function(err, rows){
              if (err) {
                console.log(err);
              } else {
                res.render('doctor/prescriptionManagement', {prescriptionDetails:rows[0], confirmedprescriptionSQL:rows[1], opdPatientInfo:null});
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
    app.post('/doctor/prescriptionManagement', function(req, res){
      if(req.session.email && req.session.sino == 'doctor'){
        if(req.session.sino == 'doctor') {
          var cancelPrescriptionSQL = 'DELETE from prescription where prescription_id = '+req.query.prescriptionId+';';
          db.query(cancelPrescriptionSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "cancelPrescription", "Canceled prescription for: '+req.query.prescriptionPatientName+'");', function(err){
            if(err){
              console.log(err);
            } else {
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
    //LAB REQUEST
    app.get('/doctor/labRequestManagement', function(req, res){
      if(req.session.email && req.session.sino == 'doctor'){
        if(req.session.sino == 'doctor'){

          if(req.query.labPatientInfo){
            var labRequestSQL = 'SELECT * from lab_request l inner join patient using(patient_id) where lab_status = "pending" and (doctor_id = '+Aid+' and patient_id = '+req.query.labPatientInfo+') ORDER BY timestamp desc;';
            var confirmedLabRequestSQL = 'SELECT * from lab_request l inner join patient using(patient_id) where lab_status = "confirmed" and patient_id = '+req.query.labPatientInfo+' ORDER BY timestamp desc;';

            db.query(labRequestSQL + confirmedLabRequestSQL, function(err, rows){
              res.render('doctor/labRequestManagement', {labrequestDetails:rows[0], confirmedLabRequestSQL:rows[1], username: user});
            });
          } else {
            var labRequestSQL = 'SELECT * from lab_request l inner join patient using(patient_id) where lab_status = "pending" ORDER BY timestamp desc;';
            var confirmedLabRequestSQL = 'SELECT * from lab_request l inner join patient using(patient_id) where lab_status = "confirmed" ORDER BY timestamp desc;';

            db.query(labRequestSQL + confirmedLabRequestSQL, function(err, rows){
              if (err) {
                console.log(err);
              } else {
                res.render('doctor/labRequestManagement', {labrequestDetails:rows[0],confirmedLabRequestSQL:rows[1], username: user});
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
    app.post('/doctor/labRequestManagement', function(req, res){
      if(req.session.email && req.session.sino == 'doctor'){
        if(req.session.sino == 'doctor') {
          var cancelLabRequestSQL = 'DELETE from lab_request where request_id = '+req.query.requestId+';';
          db.query(cancelLabRequestSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "cancelLabRequest", "Canceled lab request for: '+req.query.labrequestPatientName+'");', function(err){
            if(err){
              console.log(err);
            } else {
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
    // PROFILE MANAGEMENT
    app.get('/doctor/profileManagement', function(req, res){
      if(req.session.email && req.session.sino == 'doctor'){
        if (req.session.sino == 'doctor') {
          var profileInfoSQL  = 'SELECT name, age, address, phone from user_accounts where account_id = '+req.session.Aid+';';
          var activityLogsSQL = 'SELECT * from activity_logs where account_id = '+req.session.Aid+' ORDER by logs_id desc;';
          db.query(profileInfoSQL + activityLogsSQL, function(err, rows){
            if (err) {
              console.log(err);
            } else {
              res.render('doctor/profileManagement', {pInfo:rows[0], activityInfo: rows[1], username: user});
            }
          });
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
        res.redirect('../login')
      }
    });

    app.post('/doctor/profileManagement', function(req, res){
      var data = req.body;
      if (req.session.email && req.session.sino == 'doctor') {
        if (req.session.sino == 'doctor') {
          bcrypt.compare(data.oldPass, req.session.password, function(err, isMatch){
            if(isMatch) {
              req.flash('success', 'Successfully changed the password!');
              bcrypt.genSalt(10, function(err, salt){
                bcrypt.hash(data.newPass, salt, function(err, hash){
                  var updateProfileSQL = 'UPDATE user_accounts SET name = "'+data.name+'", age = '+data.age+', address = "'+data.address+'", phone = '+data.phone+', password = IFNULL("'+hash+'",password) WHERE account_id = '+req.session.Aid+';';
                  db.query(updateProfileSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "settingsProfileManagement", "Edited personal info.");', function(err, rows){
                    if (err) {
                      console.log(err);
                    } else {
                      if (hash) {
                        res.redirect('../logout');
                      } else {
                        res.redirect(req.get('referer'));
                      }
                    }
                  });
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
}
//CREATE A QUERY onsubmit of LAB REQUEST to be passed on the OPD tab
