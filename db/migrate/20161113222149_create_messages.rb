class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :sender_name
      t.text :body
      t.datetime :sent_at

      t.timestamps
    end
  end
end
