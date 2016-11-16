require 'rails_helper'

describe AttachmentService do
  let!(:message) {
    create(:message, {
      sender_name: 'Matheus',
      body: 'Some text.'
    })
  }

  subject(:service) {
    described_class.new({
      message_id: message.id,
      text: 'Have you seen my blog? matheusazzi.com or google it on google.com'
    })
  }

  subject(:response) {
    Struct.new(:success?, :headers, :body)
  }

  before do
    HTTParty.stub(:get).with('http://matheusazzi.com') {
      response.new(true, nil, '<title>Matheus</title>')
    }
    HTTParty.stub(:get).with('http://google.com') {
      response.new(true, nil, '<title>Google</title>')
    }
  end

  describe '#broadcast_attachment' do
    it 'broadcasts attachments to channel' do
      service.stub(:render_attachments) { 'attachments' }
      expect(ActionCable.server).to(
        receive(:broadcast).with('room_one', {
          attachments: 'attachments',
          message_id: message.id
        })
      )
      service.broadcast_attachment(channel: 'room_one')
    end

    it 'creates two attachments' do
      service.broadcast_attachment(channel: 'room_one')
      attachments = Attachment.all

      expect(attachments.size).to eq(2)
      expect(attachments.first.title).to eq('Matheus')
      expect(attachments.last.title).to eq('Google')
    end
  end
end
