require 'rails_helper'

describe MessageService do
  subject(:message_params) {
    {
      'sender_name' => 'Anonymous',
      'body' => 'Some body text.',
      'sent_at' => Time.now
    }
  }

  subject(:service) {
    described_class.new(message_params)
  }

  describe '#broadcast_message' do
    before do
      service.stub(:render_message) { 'message' }
    end

    it 'broadcasts a message to channel' do
      expect(ActionCable.server).to(
        receive(:broadcast).with('room_one', message: 'message')
      )
      service.broadcast_message(channel: 'room_one')
    end
  end
end
