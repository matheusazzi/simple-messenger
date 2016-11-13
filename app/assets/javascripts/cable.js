//= require action_cable
//= require_self
//= require_tree ./channels
//= require_tree ./components

(function() {
  this.App || (this.App = {})

  App.cable = ActionCable.createConsumer()

}).call(this)
