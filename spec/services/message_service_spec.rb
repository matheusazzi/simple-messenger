require 'rails_helper'

describe MessageService do
  subject(:message_params) {
    attributes_for(:message)
  }

  subject(:service) {
    described_class.new(message_params)
  }

  describe '#broadcast_message' do
    it 'broadcasts a message to channel' do
      service.stub(:render_message) { 'message' }
      expect(ActionCable.server).to(
        receive(:broadcast).with('room_one', message: 'message')
      )
      service.broadcast_message(channel: 'room_one')
    end

    it 'calls AttachmentBroadcastJob' do
      message = Message.create({
        sender_name: message_params['sender_name'],
        body: message_params['body'],
        sent_at: Time.now
      })

      service.stub(:message) { message }
      expect(AttachmentBroadcastJob).to(
        receive(:perform_later)
          .with(message_id: message.id, text: message.body)
      )
      service.broadcast_message(channel: 'room_one')
    end
  end
end
