var socket = io();

$(document).ready(function(){
  socket.on('type', function(value){
    if (value.what == 'lab') {
      $.notify({
          title: '<strong>New Lab Request</strong><br>',
          message: value.message,
          url: '/laboratorist/labRequestManagement',
          target: '_blank',
          icon: 'glyphicon glyphicon-plus-sign'
        },{
          type: 'success',
          allow_dismiss: false
        },{
          template: '<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-{0}" role="alert">' +
            '<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
            '<span data-notify="icon" class></span> ' +
            '<span data-notify="title">{1}</span> ' +
            '<span data-notify="message">{2}</span>' +
            '<div class="progress" data-notify="progressbar">' +
              '<div class="progress-bar progress-bar-{0}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>' +
            '</div>' +
            '<a href="{3}" target="{4}" data-notify="url"></a>' +
          '</div>'
        });
    }
  });
});
