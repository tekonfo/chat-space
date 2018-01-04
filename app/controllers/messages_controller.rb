class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @groups = current_user.groups
    @message = Message.new
    @messages = @group.messages
  end
  def create
    binding.pry
    message = Message.create(message_params)
    redirect_to  action: :index
  end

  def message_params
    params.require(:message).permit(:text, :image).merge(group_id: params[:group_id].to_i,user_id: current_user.id)
  end
end
