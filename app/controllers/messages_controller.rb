class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @groups = current_user.groups
    @message = Message.new
    @messages = @group.messages
  end
  def create
    message = Message.new(message_params)
    if message.save
      redirect_to  action: :index
      flash[:notice] = "メッセージの作成に成功しました。"
    else
      flash[:alert] = "メッセージの作成に失敗しました。"
      redirect_to  action: :index
    end

  end

  def message_params
    params.require(:message).permit(:text, :image).merge(group_id: params[:group_id].to_i,user_id: current_user.id)
  end
end
