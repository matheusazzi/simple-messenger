class Message < ApplicationRecord
  validates_presence_of :sender_name, :body, :sent_at
end
