class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(conversation_id_param)
  end

  def index
    if current_user.id == @conversation.initiator_id ||
        current_user.id == @conversation.recipient_id
      @messages = @conversation.messages
      @message = @conversation.messages.new
    else
      render file: "public/404"
    end
  end

  def new
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def conversation_id_param
    params.require(:conversation).permit(:conversation_id)
  end
end
