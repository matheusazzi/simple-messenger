class MessageService
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def broadcast_message(channel:)
    ActionCable.server.broadcast channel, message: render_message
  end

  private

  def render_message
    ApplicationController.renderer.render({
      partial: 'messages/message',
      locals: message
    })
  end

  def message
    { message: create_message }
  end

  def create_message
    Message.create({
      sender_name: data['sender_name'],
      body: data['body'],
      sent_at: Time.now
    })
  end
end
