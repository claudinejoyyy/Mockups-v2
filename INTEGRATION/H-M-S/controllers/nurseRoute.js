module.exports = function(app,db,currentTime,name,counts,chart,whoCurrentlyAdmitted,whoOPD,whoWARD,monthlyPatientCount,patientList,availableBeds,doctorList,patientManagementSQL,io,moment){
var user, Aid;
var immuSQL     = "SELECT name FROM immunization;";
var fhSQL       = "SELECT name FROM family_history;";

  app.get('/nurse/dashboard', function(req, res){
    if(req.session.email && req.session.sino == 'nurse'){
      if(req.session.sino == 'nurse'){
        Aid = req.session.Aid;
        var todoList    = "SELECT * from todo_list where account_id = "+req.session.Aid+";";
        var availablePatientOPD = "SELECT * from patient where patient_id NOT IN(SELECT patient_id from initial_assessment);";
        db.query(name + counts + chart + whoCurrentlyAdmitted + whoOPD + whoWARD + immuSQL + fhSQL + doctorList + availablePatientOPD + monthlyPatientCount + todoList, Aid, function(err, rows, fields){
          if (err) {
            console.log(err);
          }
          user = rows[0];
          res.render('nurse/dashboard', {counts:rows[1], chart:rows[2], whoCurrentlyAdmitted:rows[3], whoOPD:rows[4],whoWARD:rows[5], immu:rows[6],
                                         fh:rows[7], doctorList:rows[8], availablePatientOPD:rows[9], monthlyPatientCount:rows[10], todoList:rows[11], username: user, err:req.query.status});
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
          var vitalSigns = 'BP: '+data.BP +'\nCR: '+ data.CR +'\nPR: '+ data.PR +'\nRR: '+ data.RR +'\n TEMP: '+ data.temperature +'\nWT: '+ data.Wt;
          var initialAssessment = 'INSERT into initial_assessment (assessment, date, patient_id, account_id, vital_signs) VALUES("'+data.assessment+'", "'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'",'+nameForEmit[0]+','+data.assessmentDoctor+',"'+vitalSigns+'");';
          db.query(initialAssessment + 'INSERT into activity_logs(account_id, time, type, remarks, patient_id) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "initialAssessment", "assessment for '+req.query.assessmentPatient+'", '+nameForEmit[0]+');', function(err){
            if (err) {
              console.log(err);
            }
            io.emit('type', {what:'assess',message:'Received Assessment for '+nameForEmit[1]+', sent by Dr. <strong>'+req.session.name+'</strong>'});
          });
          res.redirect(req.get('referer'));
        } else if(data.sub == "add") {
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
          db.query(patientManagementSQL + immuSQL + fhSQL, function(err, rows){
            res.render('nurse/patientManagement', {p:rows[0], immu:rows[1], fh:rows[2], p2:null, username:user, invalid:null});
          });
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
          if (data.sub == 'add') {
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
          } else {
            var checkPassword = 'Select * from user_accounts where account_id='+Aid+' and password="'+data.patientPassword+'";';
            db.query(checkPassword, function(err, rows){
              if(err){
                console.log(err);
              } else if(rows == ''){
                var sql  = "SELECT patient_id,patient_type,name,age,sex,blood_type FROM patient where patient_id = "+req.query.passPatient+";";
                db.query(sql, function(err, errorRows){
                  res.render('nurse/patientManagement', {p:errorRows, p2:null, username:user, invalid:'error'});
                });
              } else {
                var sql  = "SELECT patient_id,patient_type,name,age,sex,blood_type FROM patient where patient_id = "+req.query.passPatient+";";
                var sql2  = "SELECT * FROM patient where patient_id = "+req.query.passPatient+";";
                db.query(sql + sql2, function(err, successRows){
                  res.render('nurse/patientManagement', {p:successRows[0], p2:successRows[1], username:user, invalid:null});
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
        db.query(bedSQL, function(err, rows, fields){
          res.render('nurse/bedManagement', {bedDetails:rows, username:user});
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

  app.get('/nurse/profileManagement', function(req, res){
    if(req.session.email && req.session.sino == 'nurse'){
      if (req.session.sino == 'nurse') {
        var profileInfoSQL  = 'SELECT * from user_accounts where account_id = '+req.session.Aid+';';
        var activityLogsSQL = 'SELECT * from activity_logs where account_id = '+req.session.Aid+' ORDER by logs_id desc LIMIT 5;';
        db.query(profileInfoSQL + activityLogsSQL, function(err, rows){
          if (err) {
            console.log(err);
          } else {
            res.render('nurse/profileManagement', {pInfo:rows[0], activityInfo: rows[1], username:user});
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
        var updateProfileSQL = 'UPDATE user_accounts SET name = "'+data.name+'", age = '+data.age+', address = "'+data.address+'", phone = '+data.phone+' WHERE account_id = '+req.session.Aid+';';
        db.query(updateProfileSQL + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "settingsProfileManagement", "Edited personal info.");', function(err, rows){
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
