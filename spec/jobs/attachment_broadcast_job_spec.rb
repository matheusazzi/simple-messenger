require 'rails_helper'

describe AttachmentBroadcastJob do
  include ActiveJob::TestHelper

  subject(:job) {
    described_class.perform_later(message_id: 1, text: '')
  }

  before do
    allow(AttachmentService).to(
      receive(:new).and_return(
        double('Service', broadcast_attachment: nil)
      )
    )
  end

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'initializes AttachmentService with correct data' do
    perform_enqueued_jobs { job }
    expect(AttachmentService).to have_received(:new).with(message_id: 1, text: '')
  end

  it 'broadcasts attachment' do
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
