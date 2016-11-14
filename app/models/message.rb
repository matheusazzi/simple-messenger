class Message < ApplicationRecord
  has_many :attachments, dependent: :destroy
  validates_presence_of :sender_name, :body, :sent_at
end
