class Attachment < ApplicationRecord
  belongs_to :message

  validate :page_or_image

  def page_or_image
    if image_url.present?
      validates_presence_of :image_url
    else
      validates_presence_of :title, :title_url
    end
  end
end
