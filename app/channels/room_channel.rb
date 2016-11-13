# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'room_channel'
  end

  def speak(data)
    # Make it asynchronous
    MessageBroadcastJob.perform_later data['message']
  end
end
