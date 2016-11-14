App.room = App.cable.subscriptions.create('RoomChannel', {
  received: function(data) {
    $('[data-component="messages"]').append(data.message)
    $('html, body').animate({ scrollTop: document.body.scrollHeight }, 300)
  },

  speak: function(message) {
    return this.perform('speak', {
      message: message
    })
  }
})
