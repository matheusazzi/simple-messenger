require 'rails_helper'

describe Message, type: :model do
  it { should validate_presence_of(:sender_name) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:sent_at) }
end