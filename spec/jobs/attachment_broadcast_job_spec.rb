require 'rails_helper'

describe AttachmentBroadcastJob do
  include ActiveJob::TestHelper

  subject(:job) {
    described_class.perform_later(message_id: 1, text: '')
  }

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'calls perform' do
    expect(AttachmentService).to(
      receive_message_chain(:new, :broadcast_attachment).with(
        channel: 'room_channel'
      )
    )
    perform_enqueued_jobs { job }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
