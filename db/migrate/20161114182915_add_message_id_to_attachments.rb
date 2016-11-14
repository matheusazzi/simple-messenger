class AddMessageIdToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_reference :attachments, :message, foreign_key: true
  end
end
