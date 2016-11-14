require 'httparty'
require 'nokogiri'

class AttachmentService
  attr_reader :message_id, :text, :attachments

  def initialize(message_id:, text:)
    @message_id = message_id
    @text = text
    @attachments = []
  end

  def broadcast_attachment(channel:)
    fetch_attachments

    if attachments.present?
      ActionCable.server.broadcast(channel, {
        attachments: render_attachments,
        message_id: message_id
      })
    end
  end

  private

  def render_attachments
    ApplicationController.renderer.render({
      partial: 'attachments/attachment',
      collection: attachments,
      as: :attachment
    })
  end

  def fetch_attachments
    urls = URI.extract(text)
    return unless urls.present?

    urls.each { |url| create_attachent(url) }
  end

  private

  def create_attachent(url)
    response = HTTParty.get(url)

    if response.success?
      @attachments <<
        if response.headers['Content-Type'].start_with?('image')
          attach_image(url)
        else
          attach_page(url, response.body)
        end
    end
  end

  def attach_image(url)
    Attachment.create(image_url: url, message_id: message_id)
  end

  def attach_page(url, body)
    page = Nokogiri::HTML(body)
    Attachment.create({
      title: page.title,
      title_url: url,
      description: page.at("meta[name='description']")['content'],
      message_id: message_id
    })
  end
end
