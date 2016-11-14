require 'rails_helper'

describe RoomsController do
  describe '#show' do
    before do
      Message.create!(body: 'Text 1', sender_name: 'user1', sent_at: Time.now)
      Message.create!(body: 'Text 2', sender_name: 'user2', sent_at: Time.now)
      get :show
    end

    it 'returns a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders a list of messages' do
      expect(assigns(:messages).size).to eq 2
      expect(assigns(:messages).first.attributes).to include({
        'body' => 'Text 1',
        'sender_name' => 'user1'
      })
      expect(assigns(:messages).last.attributes).to include({
        'body' => 'Text 2',
        'sender_name' => 'user2'
      })
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end
end
