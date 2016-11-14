class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.string :title
      t.string :title_url
      t.string :description
      t.string :image_url

      t.timestamps
    end
  end
end
