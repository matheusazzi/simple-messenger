(function($) {
  var ENTER_KEY = 13

  $(document).on('keypress', '[data-component="send-message"]', function (e) {
    if (e.keyCode === ENTER_KEY) {
      App.room.speak(e.target.value)
      e.target.value = ''
      e.preventDefault()
    }
  })
})(jQuery)
