App.room = App.cable.subscriptions.create('RoomChannel', {
  received: function(data) {
    if (data.message) {
      $('[data-component="messages"]').append(data.message)
    }

    if (data.attachments) {
      $('[data-component="attachments-'+ data.message_id +'"]').append(
        '<strong class="attachment-title">Attachments:</strong>' + data.attachments
      )
    }

    $('html, body').animate({ scrollTop: document.body.scrollHeight }, 300)
  },

  speak: function(message) {
    return this.perform('speak', {
      message: message
    })
  }
})
