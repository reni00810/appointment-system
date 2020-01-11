// For notification
function display_notify(icon, msg, type) {
  $.notify({
      icon: icon,
      message: msg
    },{
      type: type,
      allow_dismiss: true,
      newest_on_top: false,
      mouse_over: false,
      showProgressbar: false,
      spacing: 10,
      timer: 2000,
      delay: 1000,
      z_index: 10000,
      placement: {
        from: 'top',
        align: 'right'
      },
      offset: {
        x: 30,
        y: 30
      },
      animate: {
        enter: 'animated bounce',
        exit: 'animated bounce'
      }
    }
  );
}
