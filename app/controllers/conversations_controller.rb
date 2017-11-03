class ConversationsController < ApplicationController

  def index
    @conversations = Conversation.where("initiator_id = ? or recipient_id = ?",
                                        current_user.id, current_user.id)  #fix and sanitize?
  end

  def create
    if Conversation.between(params[:initiator_id],
                    params[:recipient_id]).present?   #fix and sanitize?
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(:initiator_id, :recipient_id)
  end
end
