class MessageService
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def message
    create_message
  end

  private

  def create_message
    Message.create({
      sender_name: data['username'],
      body: data['body'],
      sent_at: Time.now
    })
  end
end
