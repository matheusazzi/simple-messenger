class AttachmentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
    AttachmentService.new(data).broadcast_attachment(channel: 'room_channel')
  end
end
