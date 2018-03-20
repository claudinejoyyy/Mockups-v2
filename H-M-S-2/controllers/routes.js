module.exports = function(app, db, currentTime, bcrypt){
  app.get('/', function(req, res){
    if(req.session.email){
        res.redirect(req.session.sino+'/dashboard');
    } else {
        res.redirect('login');
    }
  });

  app.get('/login', function(req, res){
    if(req.session.email){
        res.redirect(req.session.sino+'/dashboard');
    } else {
        res.render('login');
    }
  });

  app.post('/login', function(req, res){
      // res.end(req.body.email);
      req.checkBody('username', 'username is required').notEmpty();
      req.checkBody('pass', 'password is required').notEmpty();
      if (req.validationErrors()) {
        req.flash('danger', 'Failed to login!');
        res.render('login');
      }  else {
        var username = req.body.username;
        var password = req.body.pass;
        var user  = "SELECT * FROM user_accounts WHERE username = ?;" ;

        db.query(user, username, function(err, rows, fields){
          if(err){
            console.log(err);
          }
          else if(rows == ''){
            req.flash('danger', 'Invalid Credentials!');
            res.redirect(req.get('referer'));
          } else {
            bcrypt.compare(password, rows[0].password, function(err, isMatch) {
              if (err) {
                console.log(err);
              } else if(isMatch) {
                req.session.sino = rows[0].account_type;
                req.session.Aid = rows[0].account_id;
                req.session.email = req.body.username;
                req.session.name = rows[0].name;
                req.session.password = rows[0].password;
                db.query('INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+req.session.Aid+',"'+currentTime+'", "log", "Logged in");', function(err){
                  if (err) {
                    console.log(err);
                  }
                });
                res.redirect(req.session.sino +'/dashboard');
              } else {
                req.flash('danger', 'Invalid Credentials!');
                res.redirect(req.get('referer'));
              }
            });
          }
        });
      }
  });

  app.get('/logout', function(req, res){
    if(req.session.email){
      db.query('INSERT into activity_logs(account_id, time, type, remarks) VALUES ('+req.session.Aid+',"'+currentTime+'", "log","Logged out");', function(err){
        if (err) {
          console.log(err);
        } else {
          req.session.destroy();
          res.header('Cache-Control', 'no-cache');
          res.redirect('login');
        }
      });
    } else {
      res.redirect('login');
    }
  });

  app.get('/error', function(req, res){
      res.render('error');
  });

};
