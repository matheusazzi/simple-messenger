class RoomsController < ApplicationController
  def show
    @messages = Message.includes(:attachments).all
  end
end
