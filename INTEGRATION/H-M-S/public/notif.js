var socket = io();
var ilan = 0;
$(document).ready(function(){
  var assessmentCounter = 0;
  socket.on('type', function(value){
    if (value.what == 'assess') {
      $('#OPD').css('color', 'red');
      $('#assessment').val('test').css('display','block');
    } else {
      console.log('bad');
    }

    // if (assessmentCounter > 0) {
    //   $('#OPD').css('color', 'red');
    //   console.log(assessmentCounter);
    // }
  });
});
