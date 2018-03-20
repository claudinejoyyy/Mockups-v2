// $(document).ready(function(){
//   var email, password;
//
//   $('#submit').click(function(){
//     email = $('#email').val();
//     password = $('#pass').val();
//
//     $.ajax({
//        type: "POST",
//        url: "http://localhost:3000/login",
//        data: { email: email, password: password },
//        success: function(data){
//          //HAS bug IT should be the table name not this emails
//          if(data === 'nurse@nurse.com'){
//            window.location.href = '/nurse';
//          } else if(data === 'admin@admin.com'){
//            window.location.href = '/admin';
//          } else if(data === 'phar@phar.com'){
//            window.location.href = '/pharmacist';
//          } else {
//            window.location.href = '/error';
//          }
//        }
//     });
//   });
// });
