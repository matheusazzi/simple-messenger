class MessageService
  attr_reader :data, :message

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
      locals: formatted_message
    })
  end

  def formatted_message
    { message: create_message }
  end

  def create_message
    @message = Message.create({
      sender_name: data['sender_name'],
      body: data['body'],
      sent_at: Time.now
    })

    add_attachments
    message
  end

  def add_attachments
    AttachmentBroadcastJob.perform_later(message_id: message.id, text: data['body'])
  end
end
