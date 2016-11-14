class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast 'room_channel', message: render_message(data)
  end

  private

  def message(data)
    { message: MessageService.new(data).message }
  end

  def render_message(data)
    ApplicationController.renderer.render({
      partial: 'messages/message',
      locals: message(data)
    })
  end
end
