module.exports = function(app,db,name,counts,chart,whoCurrentlyAdmitted,whoOPD,whoWARD,monthlyPatientCount,patientList,availableBeds,doctorList,patientManagementSQL,bcrypt,io,moment){
var immuSQL     = "SELECT name FROM immunization;";
var fhSQL       = "SELECT name FROM family_history;";

  app.get('/nurse/dashboard', function(req, res){
    if(req.session.email && req.session.sino == 'nurse'){
      if(req.session.sino == 'nurse'){
        var todoList    = "SELECT * from todo_list where account_id = "+req.session.Aid+";";
        var availablePatientOPD = "SELECT * from patient where patient_id NOT IN(SELECT patient_id from patient_history where status = 'pending');";
        var bed = "SELECT  * from bed where status = 'unoccupied';";
        db.query(name + counts + chart + whoCurrentlyAdmitted + whoOPD + whoWARD + immuSQL + fhSQL + doctorList + availablePatientOPD + monthlyPatientCount + todoList + bed, req.session.Aid, function(err, rows, fields){
          if (err) {
            console.log(err);
          }
          res.render('nurse/dashboard', {counts:rows[1], chart:rows[2], whoCurrentlyAdmitted:rows[3], whoOPD:rows[4],whoWARD:rows[5], immu:rows[6],
                                         fh:rows[7], doctorList:rows[8], availablePatientOPD:rows[9], monthlyPatientCount:rows[10], todoList:rows[11], bed:rows[12], username: rows[0], err:req.query.status});
        });
      } else {
        res.redirect(req.session.sino+'/dashboard');
      }
    } else {
        res.redirect('../login');
    }
  });

  app.post('/nurse/dashboard', function(req, res){
    var data = req.body;
    if(req.session.email && req.session.sino == 'nurse'){
      if(req.session.sino == 'nurse'){
        if(data.sub == 'assessment') {
          var nameForEmit = data.assessmentPatient.split(',');
          var vitalSigns  = 'BP: '+data.BP +'\nCR: '+ data.CR +'\nPR: '+ data.PR +'\nRR: '+ data.RR +'\n TEMP: '+ data.temperature +'\nWT: '+ data.Wt;
          var opdCount    = 'INSERT into opd_count (date_stamp, patient_id) values("'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", '+nameForEmit[0]+');';
          var historySQL  = 'INSERT into patient_history (date_stamp, initial_assessment, vitals, patient_id, doctor_id, status) VALUES("'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "'+data.assessment+'","'+vitalSigns+'", '+nameForEmit[0]+','+data.assessmentDoctor+',"pending");';
          db.query(historySQL + opdCount +'INSERT into activity_logs(account_id, time, type, remarks, patient_id) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "initialAssessment", "Outpatient Assessment for '+nameForEmit[1]+'", '+nameForEmit[0]+');', function(err){
            if (err) {
              console.log(err);
            }
            io.emit('type', {what:'assess',message:'Received Assessment for '+nameForEmit[1]+', sent by <strong>'+req.session.name+'</strong>'});
          });
          res.redirect(req.get('referer'));
        } else if (data.sub == 'bed') {
           var nameForBedEmit    = data.bedName.split(',');
           var bedSQL            = 'UPDATE bed set status = "occupied", allotment_timestamp = "'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", patient_id = '+nameForBedEmit[0]+' where bed_id = '+data.bed+';';
           var historySQL        = 'INSERT into patient_history (date_stamp, patient_id, doctor_id, bed, status) VALUES("'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", '+nameForBedEmit[0]+','+data.bedDoc+',"'+data.bed+', ","pending");';
           var wardCount         = 'INSERT into ward_count (date_stamp, patient_id) values("'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'",'+nameForBedEmit[0]+');';
           var bedLogs           = 'INSERT into activity_logs(account_id, time, type, remarks, patient_id) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "bed", "allotted bed number '+data.bed+' for ER patient '+nameForBedEmit[1]+'", '+nameForBedEmit[0]+');'
           db.query(historySQL + bedSQL + wardCount + bedLogs + 'INSERT into activity_logs(account_id, time, type, remarks, patient_id) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "bed", "Added ER patient '+nameForBedEmit[1]+'", '+nameForBedEmit[0]+');', function(err){
             if (err) {
               console.log(err);
             }
             io.emit('type', {what:'assess',message:'Received ER patient: '+nameForBedEmit[1]+', sent by <strong>'+req.session.name+'</strong>'});
           });
           res.redirect(req.get('referer'));
         }else if(data.sub == "add") {
            req.checkBody('name','name is required').notEmpty();
            req.checkBody('address','address is required').notEmpty();
            req.checkBody('gender','gender is required').notEmpty();
            req.checkBody('type','type is required').notEmpty();
            req.checkBody('status','status is required').notEmpty();
            req.checkBody('birth','birth is required').notEmpty();
            errors = req.validationErrors();
            if (errors) {
              res.redirect(req.get('referer'));
            } else {
              var bdParse       = data.birth.split('-');
              var birthDate     = bdParse[0] + bdParse[1] + bdParse[2];
              var cur           = new Date();
              var bd            = new Date(data.birth);
              var dif           = cur - bd;
              var age           = Math.floor(dif/31557600000);
              var fhParse       = data.family_history.split(',');
              var immuParse     = data.immunization.split(',');
              var father        = data.father + '\n:' + data.fatherO;
              var mother        = data.mother + '\n:' + data.motherO;
              var family_history = ""; for (var i = 0; i < fhParse.length; i++) {family_history += fhParse[i] + '\n';};
              var immunization   = ""; for (var i = 0; i < immuParse.length; i++) {immunization += immuParse[i] + '\n';};
              var addSQL = "INSERT INTO patient (name, unit, address, age, religion, father, mother, allergies, birth_history,birth_date, sex, patient_type, status, blood_type, rankORsn, immunization, family_history)"
                         +" VALUES ("+JSON.stringify(data.name)+", "+JSON.stringify(data.unit)+","+JSON.stringify(data.address)+","
                         +" "+age+", "+JSON.stringify(data.religion)+", "+JSON.stringify(father)+","+JSON.stringify(mother)+","
                         +" "+JSON.stringify(data.allergies)+", "+JSON.stringify(data.bh)+", "+birthDate+", "+JSON.stringify(data.gender)+","
                         +" "+JSON.stringify(data.type)+", "+JSON.stringify(data.status)+", "+JSON.stringify(data.blood)+","
                         +" "+JSON.stringify(data.rankSN)+", "+JSON.stringify(immunization)+", "+JSON.stringify(family_history)+");";

              db.query(addSQL, function(err, rows){
                if(err){
                  console.log(err);
                } else {
                  db.query('INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+req.session.Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "add", "Added: '+data.type+' - '+data.name+'");', function(err){
                    if (err) {
                      console.log(err);
                    }
                    });
                  res.redirect(req.get('referer'));
                }
              });
            }
        } else if (data.sub == 'addTodo') {
              var splitDateNTime = data.dateNtime.split('T');
              var parseDateNTime = splitDateNTime[0]+' '+splitDateNTime[1];
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
          res.redirect(req.get('referer'))
        }
      } else {
        res.redirect(req.session.sino+'/dashboard');
      }
    } else {
        res.redirect('../login');
    }
  });

//PATIENT MANAGEMENT
  app.get('/nurse/patientManagement', function(req, res){
      if(req.session.email && req.session.sino == 'nurse'){
        if(req.session.sino == 'nurse'){
          if(req.query.patient){
            var sql  = "SELECT patient_id,patient_type,name,age,sex,blood_type FROM patient where patient_id = "+req.query.patient+";";
            db.query(sql + name, req.session.Aid, function(err, rows){
              res.render('nurse/patientManagement', {p:rows[0], p2:null, med:null, username:rows[1], invalid:null});
            });
          } else {
              db.query(patientManagementSQL + name , req.session.Aid, function(err, rows){
                res.render('nurse/patientManagement', {p:rows[0], p2:null, med:null, username:rows[1], invalid:null});
              });
          }
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
          res.redirect('../login');
      }
    });

    app.post('/nurse/patientManagement', function(req, res){
      var data = req.body;
      if(req.session.email && req.session.sino == 'nurse'){
        if(req.session.sino == 'nurse') {
          if (data.sub == 'changeInfo') {
          var patientManSQL = "SELECT d.*, a.medicine,"
                         +" (SELECT time from activity_logs where type='bed' and d.patient_id = activity_logs.patient_id order by time desc limit 1) as allotment, "
                         +" (SELECT time from activity_logs where type='bedDischarge' and d.patient_id = activity_logs.patient_id order by time desc limit 1) as discharge, "
                         +" (SELECT DATEDIFF(discharge,allotment)) as difference "
                         +" FROM patient_history AS a inner join patient as d on d.patient_id = a.patient_id inner join activity_logs on d.patient_id = activity_logs.patient_id "
                         +" inner JOIN     "
                         +" ("
                         +"    SELECT    patient_id, Max(date_stamp) AS DateTime "
                         +"    FROM      patient_history "
                         +"    GROUP BY  patient_id "
                         +" ) AS b "
                         +" ON            a.patient_id = b.patient_id "
                         +" AND           a.date_stamp = b.DateTime "
                         +" and d.patient_id = "+req.query.patient_id+""
                         +" UNION "
                         +" SELECT d.*, 'New Patient' as 'medicine', "
                         +" (SELECT time from activity_logs where type='bed' and d.patient_id = activity_logs.patient_id order by time desc limit 1) as allotment, "
                         +" (SELECT time from activity_logs where type='bedDischarge' and d.patient_id = activity_logs.patient_id order by time desc limit 1) as discharge, "
                         +" (SELECT DATEDIFF(discharge,allotment)) as difference "
                         +" from patient d inner join activity_logs on d.patient_id = activity_logs.patient_id "
                         +" where d.patient_id not in "
                         +" (SELECT        a.patient_id "
                         +" FROM          patient_history AS a inner join patient as d on d.patient_id = a.patient_id "
                         +" inner JOIN "
                         +" ("
                         +"    SELECT    patient_id, Max(date_stamp) AS DateTime "
                         +"    FROM      patient_history "
                         +"    GROUP BY  patient_id "
                         +" ) AS b "
                         +" ON            a.patient_id = b.patient_id"
                         +" AND           a.date_stamp = b.DateTime)"
                         +" and d.patient_id = "+req.query.patient_id+";";
            var sql2  = "SELECT * FROM patient where patient_id = "+req.query.patient_id+";";
            var med = "select date_stamp, lab, medicine,diagnosis,bed from patient_history where patient_id = "+req.query.patient_id+" order by date_stamp;";
            var patientInfoUpdate = 'UPDATE patient SET patient_type = IFNULL("'+data.patientType+'", patient_type), name = IFNULL("'+data.name+'", name), unit = IFNULL("'+data.unit+'", unit), status = IFNULL("'+data.status+'", status), address = IFNULL("'+data.address+'", address), religion = IFNULL("'+data.religion+'", religion),blood_type = IFNULL("'+data.bloodType+'", blood_type),allergies = IFNULL("'+data.allergies+'", allergies),father = IFNULL("'+data.father+'",father),mother = IFNULL("'+data.mother+'", mother),birth_history = IFNULL("'+data.birthHistory+'",birth_history),rankORsn = IFNULL("'+data.rank+'", rankORsn),immunization = IFNULL("'+data.immunization+'", immunization),family_history = IFNULL("'+data.familyHistory+'",family_history) where patient_id = '+req.query.patient_id+'; ';
            db.query(patientManSQL + sql2 + med + patientInfoUpdate + 'INSERT into activity_logs(account_id, time, type, remarks, patient_id) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "patientInfoEdit", "Edited patient Information of '+data.name+'", '+req.query.patient_id+');', function(err, successRows){
              if (err) {
                console.log(err);
              } else {
                var patientManSQL = "SELECT d.*, a.medicine, "
                                   +" (SELECT time from activity_logs where type='bed' and d.patient_id = activity_logs.patient_id order by time desc limit 1) as allotment, "
                                   +" (SELECT time from activity_logs where type='bedDischarge' and d.patient_id = activity_logs.patient_id order by time desc limit 1) as discharge, "
                                   +" (SELECT DATEDIFF(discharge,allotment)) as difference "
                                   +" FROM patient_history AS a inner join patient as d on d.patient_id = a.patient_id inner join activity_logs on d.patient_id = activity_logs.patient_id "
                                   +" inner JOIN     "
                                   +" ("
                                   +"     SELECT    patient_id, Max(date_stamp) AS DateTime "
                                   +"    FROM      patient_history "
                                   +"    GROUP BY  patient_id "
                                   +" ) AS b "
                                   +" ON            a.patient_id = b.patient_id "
                                   +" AND           a.date_stamp = b.DateTime "
                                   +" and d.patient_id = "+req.query.patient_id+""
                                   +" UNION "
                                   +" SELECT d.*, 'New Patient' as 'medicine', "
                                   +" (SELECT time from activity_logs where type='bed' and d.patient_id = activity_logs.patient_id order by time desc limit 1) as allotment, "
                                   +" (SELECT time from activity_logs where type='bedDischarge' and d.patient_id = activity_logs.patient_id order by time desc limit 1) as discharge, "
                                   +" (SELECT DATEDIFF(discharge,allotment)) as difference "
                                   +" from patient d inner join activity_logs on d.patient_id = activity_logs.patient_id "
                                   +" where d.patient_id not in "
                                   +" (SELECT        a.patient_id "
                                   +" FROM          patient_history AS a inner join patient as d on d.patient_id = a.patient_id "
                                   +" inner JOIN "
                                   +" ("
                                   +"    SELECT    patient_id, Max(date_stamp) AS DateTime "
                                   +"    FROM      patient_history "
                                   +"    GROUP BY  patient_id "
                                   +" ) AS b "
                                   +" ON            a.patient_id = b.patient_id"
                                   +" AND           a.date_stamp = b.DateTime)"
                                   +" and d.patient_id = "+req.query.patient_id+";";
                var updatedSql2  = "SELECT * FROM patient where patient_id = "+req.query.patient_id+";";
                db.query(patientManSQL + updatedSql2 + med + name, req.session.Aid, function(err, successRows2){
                  res.render('nurse/patientManagement', {p:successRows2[0], p2:successRows2[1], med:successRows[2], username:successRows[3], invalid:null});
                });
              }
            });
          } else {
            bcrypt.compare(data.patientPassword, req.session.password, function(err, isMatch){
              if (err) {
                console.log(err);
              } else if(isMatch) {
                var patientManSQL = "SELECT d.*, a.medicine, "
                                   +" (SELECT time from activity_logs where type='bed' and d.patient_id = activity_logs.patient_id order by time desc limit 1) as allotment, "
                                   +" (SELECT time from activity_logs where type='bedDischarge' and d.patient_id = activity_logs.patient_id order by time desc limit 1) as discharge, "
                                   +" (SELECT DATEDIFF(discharge,allotment)) as difference "
                                   +" FROM patient_history AS a inner join patient as d on d.patient_id = a.patient_id inner join activity_logs on d.patient_id = activity_logs.patient_id "
                                   +" inner JOIN     "
                                   +" ("
                                   +"    SELECT    patient_id, Max(date_stamp) AS DateTime "
                                   +"    FROM      patient_history "
                                   +"    GROUP BY  patient_id "
                                   +" ) AS b "
                                   +" ON            a.patient_id = b.patient_id "
                                   +" AND           a.date_stamp = b.DateTime "
                                   +" and d.patient_id = "+req.query.passPatient+""
                                   +" UNION "
                                   +" SELECT d.*, 'New Patient' as 'medicine', "
                                   +" (SELECT time from activity_logs where type='bed' and d.patient_id = activity_logs.patient_id order by time desc limit 1) as allotment, "
                                   +" (SELECT time from activity_logs where type='bedDischarge' and d.patient_id = activity_logs.patient_id order by time desc limit 1) as discharge, "
                                   +" (SELECT DATEDIFF(discharge,allotment)) as difference "
                                   +" from patient d inner join activity_logs on d.patient_id = activity_logs.patient_id "
                                   +" where d.patient_id not in "
                                   +" (SELECT        a.patient_id "
                                   +" FROM          patient_history AS a inner join patient as d on d.patient_id = a.patient_id "
                                   +" inner JOIN "
                                   +"( "
                                   +"    SELECT    patient_id, Max(date_stamp) AS DateTime "
                                   +"    FROM      patient_history "
                                   +"    GROUP BY  patient_id "
                                   +" ) AS b "
                                   +" ON            a.patient_id = b.patient_id "
                                   +" AND           a.date_stamp = b.DateTime) "
                                   +" and d.patient_id = "+req.query.passPatient+";";
                var sql2  = "SELECT * FROM patient where patient_id = "+req.query.passPatient+";";
                var med = "select date_stamp, lab, medicine,diagnosis,bed from patient_history where patient_id = "+req.query.passPatient+" order by date_stamp;";
                db.query(patientManSQL + sql2 + med + name, req.session.Aid, function(err, successRows){
                  res.render('nurse/patientManagement', {p:successRows[0], p2:successRows[1], med:successRows[2], username:successRows[3], invalid:null});
                });
              } else {
                var sql  = "SELECT patient_id,patient_type,name,age,sex,blood_type FROM patient where patient_id = "+req.query.passPatient+";";
                db.query(sql + name, req.session.Aid, function(err, errorRows){
                  res.render('nurse/patientManagement', {p:errorRows[0], p2:null, med:null, username:errorRows[1], invalid:'error'});
                });
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


  //BEDMANAGEMENT
  app.get('/nurse/bedManagement', function(req, res){
    if (req.session.email && req.session.sino == 'nurse') {
      if (req.session.sino == 'nurse') {
        var bedSQL = "SELECT b.bed_id, p.patient_type, p.name, b.status, b.allotment_timestamp from bed b LEFT JOIN patient p USING(patient_id); ";
        db.query(bedSQL + name, req.session.Aid, function(err, rows, fields){
          res.render('nurse/bedManagement', {bedDetails:rows[0], username:rows[1]});
        });
      } else {
        res.redirect(req.session.sino+'/dashboard');
      }
    } else {
      res.redirect('../login');
    }
  });

  app.post('/nurse/bedManagement', function(req, res){
    if(req.session.email && req.session.sino == 'nurse'){
      if(req.session.sino == 'nurse') {
        var dischargeSQL = "UPDATE bed SET status = 'Unoccupied', allotment_timestamp = NULL, patient_id = NULL where bed_id = "+req.query.bed+";";
        db.query(dischargeSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "bedDischarge", "Discharged a patient from bed number : '+req.query.bed+'");', function(err, rows, fields){
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
    app.get('/nurse/profileManagement', function(req, res){
      if(req.session.email && req.session.sino == 'nurse'){
        if (req.session.sino == 'nurse') {
          var profileInfoSQL  = 'SELECT name, age, account_id, sex, address, phone from user_accounts where account_id = '+req.session.Aid+';';
          var activityLogsSQL = 'SELECT * from activity_logs where account_id = '+req.session.Aid+' ORDER by logs_id desc LIMIT 10;';
          db.query(profileInfoSQL + activityLogsSQL + name,req.session.Aid, function(err, rows){
            if (err) {
              console.log(err);
            } else {
              res.render('nurse/profileManagement', {pInfo:rows[0], activityInfo: rows[1], username: rows[2]});
            }
          });
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
        res.redirect('../login')
      }
    });

    app.post('/nurse/profileManagement', function(req, res){
      var data = req.body;
      if (req.session.email && req.session.sino == 'nurse') {
        if (req.session.sino == 'nurse') {
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

}
