require 'rails_helper'

describe MessageBroadcastJob do
  include ActiveJob::TestHelper

  subject(:data) {
    {
      'sender_name' => 'Anonymous',
      'body' => 'Some body text.'
    }
  }

  subject(:job) {
    described_class.perform_later(data)
  }

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'calls perform' do
    expect(MessageService).to receive_message_chain(:new, :broadcast_message).with(
      channel: 'room_channel'
    )
    perform_enqueued_jobs { job }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
