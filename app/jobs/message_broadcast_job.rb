class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
    MessageService.new(data).broadcast_message(channel: 'room_channel')
  end
end
