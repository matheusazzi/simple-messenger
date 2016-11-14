(function($) {
  var ENTER_KEY = 13

  $(document).on('keypress', '[data-component="send-message"]', function (e) {
    if (e.keyCode === ENTER_KEY && e.target.value) {
      $.post('/api/v1/messages', {
        message: {
          sender_name: $('[name="username"]').val().trim() || 'Anonymous',
          body: e.target.value
        }
      })
      e.target.value = ''
      e.preventDefault()
    }
  })
})(jQuery)
