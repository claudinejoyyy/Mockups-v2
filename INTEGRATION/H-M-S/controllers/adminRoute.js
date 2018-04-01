module.exports = function(app,db,name,counts,chart,whoCurrentlyAdmitted,whoOPD,whoWARD,monthlyPatientCount,patientList,availableBeds,patientManagementSQL,bcrypt,io,moment){
var user, Aid;

app.get('/admin/dashboard', function(req, res){
  if(req.session.email && req.session.sino == 'admin'){
    Aid = req.session.Aid;
    if(req.session.sino == 'admin'){
      var todoList    = "SELECT * from todo_list where account_id = "+Aid+";";
      db.query(name + counts + chart + whoCurrentlyAdmitted + whoOPD + whoWARD + patientList + availableBeds + monthlyPatientCount + todoList, Aid, function(err, rows, fields){
        if (err) {
          console.log(err);
        }
        user = rows[0];
        availableBedss = rows[7];
        res.render('admin/dashboard', {counts:rows[1], chart:rows[2], whoCurrentlyAdmitted:rows[3], whoOPD:rows[4], whoWARD:rows[5], patientList:rows[6],
                                       availableBeds:rows[7], monthlyPatientCount:rows[8], todoList:rows[9], username: user});
     });
    } else {
      res.redirect(req.session.sino + '/dashboard');
    }
  } else {
    res.redirect('../login');
  }
});

app.post('/admin/dashboard', function(req, res){
  var data = req.body;
  if(req.session.email && req.session.sino == 'admin'){
      if (req.session.sino == 'admin') {
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
//PATIENT MANAGEMENT
app.get('/admin/patientManagement', function(req, res){
    if(req.session.email && req.session.sino == 'admin'){
      if(req.session.sino == 'admin'){
        var sql  = "SELECT patient_id,patient_type,name,age,sex,blood_type FROM patient";
        db.query(sql, function(err, rows){
          res.render('admin/patientManagement', {p:rows, username:user});
        });
      } else {
        res.redirect(req.session.sino+'/dashboard');
      }
    } else {
        res.redirect('../login');
    }
  });

  // PROFILE MANAGEMENT
    app.get('/admin/profileManagement', function(req, res){
      if(req.session.email && req.session.sino == 'admin'){
        if (req.session.sino == 'admin') {
          var profileInfoSQL  = 'SELECT name, age, account_id, sex, address, phone from user_accounts where account_id = '+req.session.Aid+';';
          var activityLogsSQL = 'SELECT * from activity_logs where account_id = '+req.session.Aid+' ORDER by logs_id desc LIMIT 10;';
          db.query(profileInfoSQL + activityLogsSQL, function(err, rows){
            if (err) {
              console.log(err);
            } else {
              res.render('admin/profileManagement', {pInfo:rows[0], activityInfo: rows[1], username: user});
            }
          });
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
        res.redirect('../login')
      }
    });

    app.post('/admin/profileManagement', function(req, res){
      var data = req.body;
      if (req.session.email && req.session.sino == 'admin') {
        if (req.session.sino == 'admin') {
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

  //USER ACCOUNTS MANAGEMENT
  app.get('/admin/userAccountsManagement', function(req, res){
      if(req.session.email && req.session.sino == 'admin'){
        if(req.session.sino == 'admin'){
            var sql  = "SELECT account_id, account_type, name, age, sex, max(time) as last_Login FROM user_accounts left join activity_logs using(account_id) where account_id !="+Aid+" group by account_id;";
            var filterPharma = "select * from user_accounts where account_type = 'pharmacist';";
            var filterLab = "select * from user_accounts where account_type = 'laboratorist';";
            var filterAdmin = "select * from user_accounts where account_type = 'admin';";
            db.query(sql + filterPharma +filterLab + filterAdmin, function(err, rows){
              res.render('admin/userAccountsManagement', {p:rows[0], pharma:rows[1], lab:rows[2], adm:rows[3], username:user});
            });
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
          res.redirect('../login');
      }
    });

    app.post('/admin/userAccountsManagement', function(req, res){
      var data = req.body;
      if (req.session.email && req.session.sino == 'admin') {
        if (req.session.sino == 'admin') {
          if (data.sub == 'remove') {
            var deleteUserAccount = 'DELETE FROM user_accounts where account_id = '+req.query.account+';';
            db.query(deleteUserAccount + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "removedUser", "removed user: '+req.query.name+'");', function(err, rows){
              if (err) {
                console.log(err);
              } else {
                res.redirect(req.get('referer'));
              }
            });
          } else if (data.sub == 'add') {
            req.checkBody('type','type is required.').notEmpty();
            req.checkBody('gender','gender is required.').notEmpty();
            req.checkBody('user','username is required.').notEmpty();
            req.checkBody('pass','password is required.').notEmpty();
            req.checkBody('name','name is required.').notEmpty();
            req.checkBody('birth','birth date is required.').notEmpty();
            req.checkBody('phone','phone is required.').notEmpty();
            req.checkBody('address','address is required.').notEmpty();
            var errors = req.validationErrors();
            if (errors) {
              req.flash('danger', 'Failed to add user account!');
              res.redirect(req.get('referer'));
            } else {
              db.query('SELECT * from user_accounts where username = "'+data.user+'";', function(err, rows){
                if (rows.length > 0) {
                  req.flash('danger', 'Username already exist!');
                  res.redirect(req.get('referer'));
                } else {
                  //FOR the calculation of age !!
                  var cur           = new Date();
                  var bd            = new Date(data.birth);
                  var dif           = cur - bd;
                  var age           = Math.floor(dif/31557600000);
                  bcrypt.genSalt(10, function(err, salt){
                    bcrypt.hash(data.pass, salt, function(err, hash){
                      if (err) {
                        console.log(err);
                      }
                      var addUserAccount = 'INSERT into user_accounts (username, password, account_type, name, age, sex, address, phone) VALUES ("'+data.user+'","'+hash+'","'+data.type+'","'+data.name+'",'+age+',"'+data.gender+'","'+data.address+'","'+data.phone+'");';
                      db.query(addUserAccount + 'INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+Aid+',"'+moment(new Date()).format('YYYY-MM-DD HH:mm:ss')+'", "addUser", "Added user: '+data.name+'");', function(err, rows){
                        if (err) {
                          console.log(err);
                        } else {
                          req.flash('success', 'user account successfully added !');
                          res.redirect(req.get('referer'));
                        }
                      });
                    });
                  });
                }
              });
            }
          }
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
        res.redirect('../login');
      }
    });

    //BED MANAGEMENT
    app.get('/admin/bedManagement', function(req, res){
      if (req.session.email && req.session.sino == 'admin') {
        if (req.session.sino == 'admin') {
            var bedSQL = "SELECT b.bed_id, p.patient_type, p.name, b.status, b.allotment_timestamp from bed b LEFT JOIN patient p USING(patient_id); ";
            db.query(bedSQL, function(err, rows, fields){
              res.render('admin/bedManagement', {bedDetails:rows, username: user});
            });
        } else {
          res.redirect(req.session.sino+'/dashboard');
        }
      } else {
        res.redirect('../login');
      }
    });
}
