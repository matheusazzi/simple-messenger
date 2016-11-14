require 'rails_helper'

describe Api::V1::MessagesController do
  describe '#create' do
    let(:message_params) {
      { message: { sender_name: 'Anonymous', body: 'Some body text.' } }
    }

    it 'returns a 204 status code' do
      post :create, params: message_params
      expect(response).to have_http_status(:no_content)
    end

    it 'starts MessageBroadcastJob' do
      expect(MessageBroadcastJob).to(
        receive(:perform_later).with(message_params[:message]).once
      )
      post :create, params: message_params
    end
  end
end
