App.room = App.cable.subscriptions.create('RoomChannel', {
  received: function(data) {
    $('#messages').append(data['message'])
  },

  speak: function(message) {
    return this.perform('speak', { message: message })
  }
})
