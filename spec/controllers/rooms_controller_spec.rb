require 'rails_helper'

describe RoomsController do
  describe '#show' do
    let!(:message_one) { create(:message) }
    let!(:message_two) { create(:message) }

    before do
      get :show
    end

    it 'returns a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders a list of messages' do
      expect(assigns(:messages).size).to eq 2
      expect(assigns(:messages).first.attributes).to include({
        'body' => message_one.body,
        'sender_name' => message_one.sender_name
      })
      expect(assigns(:messages).last.attributes).to include({
        'body' => message_two.body,
        'sender_name' => message_two.sender_name
      })
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end
end
