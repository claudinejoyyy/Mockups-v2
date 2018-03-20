module.exports = function(app,db,currentTime,name,counts,chart,whoCurrentlyAdmitted,whoOPD,whoWARD,monthlyPatientCount,patientList,availableBeds,patientManagementSQL,bcrypt,moment){
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
                  todoLog = 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+req.session.Aid+',"'+currentTime+'", "urgentTodo", "Added to do urgent: '+data.description+'");';
                } else if(data.todoStatus == 'general') {
                  console.log('Added to general!!!!');
                  todoLog = 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+req.session.Aid+',"'+currentTime+'", "generalTodo", "Added to do general: '+data.description+'");';
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
                res.redirect(req.get('referer'))

              } else if(data.sub == 'appointment') {
                    var splitDateNTime = data.dateNtime.split('T');
                    var parseDate      = splitDateNTime[0];
                    var parseTime      = splitDateNTime[1] + ':00';
                    var parseDateNTime = parseDate+' '+parseTime;
                    var addAppointment = 'INSERT into appointment (doctor_id, patient_id, appointment_timestamp, remarks) VALUES ('+Aid+', '+data.appointmentPatientID+', "'+parseDateNTime+'", "'+data.appointmentRemarks+'");';
                    db.query(addAppointment + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+currentTime+'", "appointment", "Set Appointment with '+req.query.appointmentPatientName+' on '+parseDateNTime+'");', function(err){
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
          var outpatientDepartmentSQL = 'SELECT * FROM patient inner join initial_assessment i using(patient_id) where i.account_id = '+Aid+' and patient_id NOT IN (SELECT patient_id from diagnosis) order by patient_id;';
          var labSQL                  = 'SELECT * from lab_request left join initial_assessment using(patient_id);';
          var prescribeSQL            = 'SELECT * from prescription inner join patient using(patient_id) group by patient_id;';
          var whoCurrentlyAdmittedV2  = 'SELECT * FROM patient p left join initial_assessment i ON p.patient_id = i.patient_id left join bed a ON p.patient_id = a.patient_id where i.account_id = '+Aid+' and p.patient_id NOT IN (SELECT patient_id from diagnosis) order by p.patient_id;';

          db.query(outpatientDepartmentSQL + availableBeds + whoCurrentlyAdmittedV2 + labSQL + prescribeSQL, function(err, rows){
          if (err) {
            console.log(err);
          } else {
              res.render('doctor/outpatientManagement', {opdInfo:rows[0], admitAvailableBeds:rows[1], whoCurrentlyAdmittedV2:rows[2], labSQL:rows[3], prescribeSQL:rows[4], username: user});
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
            var bedSQL = 'UPDATE bed set allotment_timestamp = "'+currentTime+'", patient_id = '+req.query.patient_id+',status = "occupied" where bed_id = '+data.bedNumber+';';
            db.query(bedSQL + 'INSERT into activity_logs(account_id, time, type, remarks, patient_id) VALUES ('+Aid+',"'+currentTime+'", "bed", "Alloted bed number: '+data.bedNumber+' to patient:'+req.query.patient_name+'",'+req.query.patient_id+');', function(err){
              if (err) {
                console.log(err);
              } else {
                res.redirect(req.get('referer'));
              }
            });
          } else if(data.sub == 'prescribe') {
            var prescribeSQL = 'INSERT into prescription (creation_stamp, medicine, quantity, dosage, timeframe, doctor_id, patient_id, status) VALUES ("'+currentTime+'","'+data.medicine+'",'+data.quantity+',"'+data.dosage+'","'+data.timeframe+'",'+Aid+','+req.query.patient_id+',"Pending");';
            db.query(prescribeSQL +  'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+currentTime+'", "prescription", "Prescribed a medicine to : '+req.query.patient_name+'");', function(err){
              if (err) {
                console.log(err);
              } else {
                res.redirect(req.get('referer'));
              }
            });
          } else if (data.sub == 'labRequest') {
            var requestSQL = 'INSERT into lab_request(type,timestamp,remarks,doctor_id,patient_id,lab_status) VALUES("'+data.testRequest+'","'+currentTime+'","'+data.labRequestremarks+'",'+Aid+','+req.query.patient_id+',"Pending");';
            db.query(requestSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+currentTime+'", "labRequest", "Lab request for : '+req.query.patient_name+');', function(err){
              if (err) {
                console.log(err);
              } else {
                res.redirect(req.get('referer'));
              }
            });
          } else if (data.sub == 'diag') {
            var diagnosisSQL = 'INSERT into diagnosis (diagnosis, date, patient_id, doctor_id) VALUES ("'+data.diagnosis+'","'+currentTime+'",'+req.query.patient_id+','+Aid+');';
            var assessmentDel = 'DELETE from assessment where patient_id = '+req.query.patient_id+';';
            db.query(diagnosisSQL + assessmentDel + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+currentTime+'", "diagnosis", "diagnosis for : '+req.query.patient_name+'");', function(err){
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
          var bedSQL = "SELECT b.bed_id, p.patient_type, p.name, b.status, b.allotment_timestamp from bed b LEFT JOIN patient p USING(patient_id) where bed_id = "+req.query.bed_id+"; ";
          db.query(bedSQL, function(err, rows, fields){
            res.render('doctor/bedManagement', {bedDetails:rows, username: user});
          });
        } else {
          var bedSQL = "SELECT b.bed_id, p.patient_type, p.name, b.status, b.allotment_timestamp from bed b LEFT JOIN patient p USING(patient_id); ";
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
        db.query(dischargeSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+currentTime+'", "bedDischarge", "Discharged a patient from bed number : '+req.query.bed+'");', function(err, rows, fields){
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
              res.render('doctor/patientManagement', {p:rows, p2:null, username:user, invalid:null});
            });
          } else {
              db.query(patientManagementSQL, function(err, rows){
                res.render('doctor/patientManagement', {p:rows, p2:null, username:user, invalid:null});
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
              var latestMedicine =  'SELECT medicine FROM `prescription` where status="confirmed" and patient_id = '+req.query.passPatient+' and creation_stamp = (SELECT creation_stamp from prescription where patient_id = '+req.query.passPatient+' and status="confirmed" order by creation_stamp desc limit 1);'
              db.query(sql + sql2 + latestMedicine, function(err, successRows){
                var medicineParse = JSON.parse(JSON.stringify(successRows[2]));
                var medicine= '';
                for (var i = 0; i < medicineParse.length; i++) {
                  medicine += medicineParse[i].medicine + ',\n';
                }
                res.render('doctor/patientManagement', {p:successRows[0], p2:successRows[1], medicine:medicine, username:user, invalid:null});
              });
            } else {
              var sql  = "SELECT patient_id,patient_type,name,age,sex,blood_type FROM patient where patient_id = "+req.query.passPatient+";";
              db.query(sql, function(err, errorRows){
                res.render('doctor/patientManagement', {p:errorRows, p2:null, username:user, invalid:'error'});
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
          db.query(cancelAppointmentSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+currentTime+'", "cancelAppointment", "Canceled appointment with: '+req.query.appointmentPatientName+'");', function(err){
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
            var prescriptionSQL = 'SELECT CONCAT("Medicine: ",medicine,"\nQuantity: ",quantity,"\nDosage: ", dosage,"\nTimeframe: ", timeframe) AS medications, p.status as STATUS,creation_stamp,patient_type,name,age,prescription_id from prescription p inner join patient using(patient_id) where doctor_id = '+Aid+' and patient_id = '+req.query.opdPatient+' and p.status ="pending" ORDER BY creation_stamp desc;';
            var confirmedprescriptionSQL = 'SELECT CONCAT("mMedicine: ",medicine,"\nQuantity: ",quantity,"\nDosage: ", dosage,"\nTimeframe: ", timeframe) AS medications, p.status as STATUS,creation_stamp,patient_type,name,age,prescription_id from prescription p inner join patient using(patient_id) where p.status = "confirmed" and doctor_id='+Aid+' ORDER BY creation_stamp desc;';

            db.query(prescriptionSQL+confirmedprescriptionSQL, function(err, rows){
              if (err) {
                console.log(err);
              } else {
                res.render('doctor/prescriptionManagement', {prescriptionDetails:rows[0], confirmedprescriptionSQL:rows[1], opdPatientInfo:req.query.opdPatient, username: user});
              }
            });
          } else {
            var prescriptionSQL = 'SELECT CONCAT("Medicine: ",medicine,"\nQuantity: ",quantity,"\nDosage: ", dosage,"\nTimeframe: ", timeframe) AS medications, p.status as STATUS,creation_stamp,patient_type,name,age,prescription_id from prescription p inner join patient using(patient_id) where doctor_id = '+Aid+' and p.status ="pending" ORDER BY creation_stamp desc;';
            var confirmedprescriptionSQL = 'SELECT CONCAT("Medicine: ",medicine,"\nQuantity: ",quantity,"\nDosage: ", dosage,"\nTimeframe: ", timeframe) AS medications, p.status as STATUS,creation_stamp,patient_type,name,age,prescription_id from prescription p inner join patient using(patient_id) where p.status = "confirmed" and doctor_id='+Aid+' ORDER BY creation_stamp desc;';

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
          db.query(cancelPrescriptionSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+currentTime+'", "cancelPrescription", "Canceled prescription for: '+req.query.prescriptionPatientName+'");', function(err){
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
          db.query(cancelLabRequestSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+currentTime+'", "cancelLabRequest", "Canceled lab request for: '+req.query.labrequestPatientName+'");', function(err){
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
          var profileInfoSQL  = 'SELECT * from user_accounts where account_id = '+req.session.Aid+';';
          var activityLogsSQL = 'SELECT * from activity_logs where account_id = '+req.session.Aid+' ORDER by logs_id desc LIMIT 5;';
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
          var updateProfileSQL = 'UPDATE user_accounts SET name = "'+data.name+'", age = '+data.age+', address = "'+data.address+'", phone = '+data.phone+' WHERE account_id = '+req.session.Aid+';';
          db.query(updateProfileSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+currentTime+'", "settingsProfileManagement", "Edited personal info.");', function(err, rows){
            if (err) {
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
}
//CREATE A QUERY onsubmit of LAB REQUEST to be passed on the OPD tab
