module Api::V1
  class MessagesController < ApiController
    def create
      # Make it asynchronous
      MessageBroadcastJob.perform_later message_params.to_h
      head :no_content
    end

    private

    def message_params
      params.require(:message).permit(
        :sender_name,
        :body
      )
    end
  end
end
